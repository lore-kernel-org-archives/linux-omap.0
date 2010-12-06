From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: [v3,05/12] staging: tidspbridge: rmgr/node.c code cleanup
Date: Mon, 6 Dec 2010 03:21:56 -0600
Message-ID: <AANLkTi=gR_mgAVM4yJgWftZpSAKeKP+iKaLd895xmHnN@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog109.obsmtp.com ([74.125.149.201]:47188 "EHLO
	na3sys009aog109.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752133Ab0LFJV5 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 6 Dec 2010 04:21:57 -0500
Received: by mail-iw0-f178.google.com with SMTP id 1so17049308iwn.37
        for <linux-omap@vger.kernel.org>; Mon, 06 Dec 2010 01:21:56 -0800 (PST)
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Ionut Nicu <ionut.nicu@gmail.com>
Cc: Greg KH <greg@kroah.com>, "Sapiens, Rene" <rene.sapiens@ti.com>, andy.shevchenko@gmail.com, Fernando Guzman Lugo <fernando.lugo@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

> Reorganized some code in rmgr/node.c to increase its
> readability. Most of the changes reduce the code
> indentation level and simplifiy the code. No functional
> changes were done.
>
> Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
>
> ---
> drivers/staging/tidspbridge/rmgr/node.c |  607 +++++++++++++++----------------
>  1 files changed, 284 insertions(+), 323 deletions(-)
>
> diff --git a/drivers/staging/tidspbridge/rmgr/node.c b/drivers/staging/tidspbridge/rmgr/node.c
...
> @@ -918,170 +908,143 @@ int node_connect(struct node_object *node1, u32 stream1,
>  		DBC_ASSERT(node2 != (struct node_object *)DSP_HGPPNODE);
>  		hnode_mgr = node2->hnode_mgr;
>  	}
> +
>  	/* Enter critical section */
>  	mutex_lock(&hnode_mgr->node_mgr_lock);
>
>  	/* Nodes must be in the allocated state */
> -	if (node1_type != NODE_GPP && node_get_state(node1) != NODE_ALLOCATED)
> +	if (node1_type != NODE_GPP &&
> +			node_get_state(node1) != NODE_ALLOCATED) {
>  		status = -EBADR;
> +		goto out_unlock;
> +	}
>
> -	if (node2_type != NODE_GPP && node_get_state(node2) != NODE_ALLOCATED)
> +	if (node2_type != NODE_GPP &&
> +			node_get_state(node2) != NODE_ALLOCATED) {
>  		status = -EBADR;
> +		goto out_unlock;
> +	}
>
> -	if (!status) {
> -		/*  Check that stream indices for task and dais socket nodes
> -		 *  are not already be used. (Device nodes checked later) */
> -		if (node1_type == NODE_TASK || node1_type == NODE_DAISSOCKET) {
> -			output =
> -			    &(node1->create_args.asa.
> -			      task_arg_obj.strm_out_def[stream1]);
> -			if (output->sz_device != NULL)
> -				status = -EISCONN;
> -
> +	/*  Check that stream indices for task and dais socket nodes
> +	 *  are not already be used. (Device nodes checked later) */

Please follow the convention for multi line comments

> +	if (node1_type == NODE_TASK || node1_type == NODE_DAISSOCKET) {
> +		output = &(node1->create_args.asa.
> +				task_arg_obj.strm_out_def[stream1]);
> +		if (output->sz_device != NULL) {

can we use the simplified form?

if (output->sz_device)

> +			status = -EISCONN;
> +			goto out_unlock;
>  		}
> -		if (node2_type == NODE_TASK || node2_type == NODE_DAISSOCKET) {
> -			input =
> -			    &(node2->create_args.asa.
> -			      task_arg_obj.strm_in_def[stream2]);
> -			if (input->sz_device != NULL)
> -				status = -EISCONN;
>
> +	}
> +	if (node2_type == NODE_TASK || node2_type == NODE_DAISSOCKET) {
> +		input = &(node2->create_args.asa.
> +				task_arg_obj.strm_in_def[stream2]);
> +		if (input->sz_device != NULL) {

same here

> +			status = -EISCONN;
> +			goto out_unlock;
>  		}
> +
>  	}
>  	/* Connecting two task nodes? */
> -	if (!status && ((node1_type == NODE_TASK ||
> -				       node1_type == NODE_DAISSOCKET)
> -				      && (node2_type == NODE_TASK
> -					  || node2_type == NODE_DAISSOCKET))) {
> +	if (((node1_type == NODE_TASK || node1_type == NODE_DAISSOCKET) &&
> +				(node2_type == NODE_TASK ||
> +				 node2_type == NODE_DAISSOCKET))) {

extra set of parenthesis

>  		/* Find available pipe */
>  		pipe_id = find_first_zero_bit(hnode_mgr->pipe_map, MAXPIPES);
>  		if (pipe_id == MAXPIPES) {
>  			status = -ECONNREFUSED;
> -		} else {
> -			set_bit(pipe_id, hnode_mgr->pipe_map);
> -			node1->outputs[stream1].type = NODECONNECT;
> -			node2->inputs[stream2].type = NODECONNECT;
> -			node1->outputs[stream1].dev_id = pipe_id;
> -			node2->inputs[stream2].dev_id = pipe_id;
> -			output->sz_device = kzalloc(PIPENAMELEN + 1,
> -							GFP_KERNEL);
> -			input->sz_device = kzalloc(PIPENAMELEN + 1, GFP_KERNEL);
> -			if (output->sz_device == NULL ||
> -			    input->sz_device == NULL) {
> -				/* Undo the connection */
> -				kfree(output->sz_device);
> -
> -				kfree(input->sz_device);
> -
> -				output->sz_device = NULL;
> -				input->sz_device = NULL;
> -				clear_bit(pipe_id, hnode_mgr->pipe_map);
> -				status = -ENOMEM;
> -			} else {
> -				/* Copy "/dbpipe<pipId>" name to device names */
> -				sprintf(output->sz_device, "%s%d",
> -					PIPEPREFIX, pipe_id);
> -				strcpy(input->sz_device, output->sz_device);
> -			}
> +			goto out_unlock;
> +		}
> +		set_bit(pipe_id, hnode_mgr->pipe_map);
> +		node1->outputs[stream1].type = NODECONNECT;
> +		node2->inputs[stream2].type = NODECONNECT;
> +		node1->outputs[stream1].dev_id = pipe_id;
> +		node2->inputs[stream2].dev_id = pipe_id;
> +		output->sz_device = kzalloc(PIPENAMELEN + 1, GFP_KERNEL);
> +		input->sz_device = kzalloc(PIPENAMELEN + 1, GFP_KERNEL);
> +		if (output->sz_device == NULL || input->sz_device == NULL) {

simplified form can be used

> +			/* Undo the connection */
> +			kfree(output->sz_device);
> +			kfree(input->sz_device);
> +			output->sz_device = NULL;
> +			input->sz_device = NULL;

this seems redundant given that if the condition is triggered at least
one will be NULL

> +			clear_bit(pipe_id, hnode_mgr->pipe_map);
> +			status = -ENOMEM;
> +			goto out_unlock;
>  		}
> +		/* Copy "/dbpipe<pipId>" name to device names */
> +		sprintf(output->sz_device, "%s%d", PIPEPREFIX, pipe_id);
> +		strcpy(input->sz_device, output->sz_device);
>  	}
>  	/* Connecting task node to host? */
> -	if (!status && (node1_type == NODE_GPP ||
> -				      node2_type == NODE_GPP)) {
> -		if (node1_type == NODE_GPP) {
> -			chnl_mode = CHNL_MODETODSP;
> -		} else {
> -			DBC_ASSERT(node2_type == NODE_GPP);
> -			chnl_mode = CHNL_MODEFROMDSP;
> +	if ((node1_type == NODE_GPP || node2_type == NODE_GPP)) {

extra parenthesis

> +		pstr_dev_name = kzalloc(HOSTNAMELEN + 1, GFP_KERNEL);
> +		if (!pstr_dev_name) {
> +			status = -ENOMEM;
> +			goto out_unlock;
>  		}
> +
> +		DBC_ASSERT((node1_type == NODE_GPP) ||
> +				(node2_type == NODE_GPP));
> +
> +		chnl_mode = (node1_type == NODE_GPP) ?
> +			CHNL_MODETODSP : CHNL_MODEFROMDSP;
> +
>  		/*  Reserve a channel id. We need to put the name "/host<id>"
>  		 *  in the node's create_args, but the host
>  		 *  side channel will not be opened until DSPStream_Open is
>  		 *  called for this node. */
> -		if (pattrs) {
> -			if (pattrs->strm_mode == STRMMODE_RDMA) {
> -				chnl_id = find_first_zero_bit(
> -						hnode_mgr->dma_chnl_map,
> -						CHNL_MAXCHANNELS);
> +		strm_mode = pattrs ? pattrs->strm_mode : STRMMODE_PROCCOPY;
> +		switch (strm_mode) {
> +		case STRMMODE_RDMA:
> +			chnl_id = find_first_zero_bit(hnode_mgr->dma_chnl_map,
> +					CHNL_MAXCHANNELS);
> +			if (chnl_id < CHNL_MAXCHANNELS) {
> +				set_bit(chnl_id, hnode_mgr->dma_chnl_map);
>  				/* dma chans are 2nd transport chnl set
>  				 * ids(e.g. 16-31) */
> -				if (chnl_id != CHNL_MAXCHANNELS) {
> -					set_bit(chnl_id,
> -						hnode_mgr->dma_chnl_map);
> -					chnl_id = chnl_id +
> -						hnode_mgr->ul_num_chnls;
> -				}
> -			} else if (pattrs->strm_mode == STRMMODE_ZEROCOPY) {
> -				chnl_id = find_first_zero_bit(
> -						hnode_mgr->zc_chnl_map,
> -						CHNL_MAXCHANNELS);
> +				chnl_id = chnl_id + hnode_mgr->ul_num_chnls;
> +			}
> +			break;
> +		case STRMMODE_ZEROCOPY:
> +			chnl_id = find_first_zero_bit(hnode_mgr->zc_chnl_map,
> +					CHNL_MAXCHANNELS);
> +			if (chnl_id < CHNL_MAXCHANNELS) {
> +				set_bit(chnl_id, hnode_mgr->zc_chnl_map);
>  				/* zero-copy chans are 3nd transport set
>  				 * (e.g. 32-47) */
> -				if (chnl_id != CHNL_MAXCHANNELS) {
> -					set_bit(chnl_id,
> -						hnode_mgr->zc_chnl_map);
> -					chnl_id = chnl_id +
> -						(2 * hnode_mgr->ul_num_chnls);
> -				}
> -			} else {	/* must be PROCCOPY */
> -				DBC_ASSERT(pattrs->strm_mode ==
> -					   STRMMODE_PROCCOPY);
> -				chnl_id = find_first_zero_bit(
> -						hnode_mgr->chnl_map,
> -						CHNL_MAXCHANNELS);
> -				/* e.g. 0-15 */
> -				if (chnl_id != CHNL_MAXCHANNELS)
> -					set_bit(chnl_id, hnode_mgr->chnl_map);
> +				chnl_id = chnl_id +
> +					(2 * hnode_mgr->ul_num_chnls);
>  			}
> -		} else {
> -			/* default to PROCCOPY */
> +			break;
> +		case STRMMODE_PROCCOPY:
>  			chnl_id = find_first_zero_bit(hnode_mgr->chnl_map,
>  					CHNL_MAXCHANNELS);
> -			if (chnl_id != CHNL_MAXCHANNELS)
> +			if (chnl_id < CHNL_MAXCHANNELS)
>  				set_bit(chnl_id, hnode_mgr->chnl_map);
> +			break;
> +		default:
> +			status = -EINVAL;
> +			goto out_unlock;
>  		}
>  		if (chnl_id == CHNL_MAXCHANNELS) {
>  			status = -ECONNREFUSED;
> -			goto func_cont2;
> +			goto out_unlock;
>  		}
> -		pstr_dev_name = kzalloc(HOSTNAMELEN + 1, GFP_KERNEL);
> -		if (pstr_dev_name != NULL)
> -			goto func_cont2;
> -
> -		if (pattrs) {
> -			if (pattrs->strm_mode == STRMMODE_RDMA) {
> -				clear_bit(chnl_id - hnode_mgr->ul_num_chnls,
> -						hnode_mgr->dma_chnl_map);
> -			} else if (pattrs->strm_mode == STRMMODE_ZEROCOPY) {
> -				clear_bit(chnl_id -
> -						(2 * hnode_mgr->ul_num_chnls),
> -						hnode_mgr->zc_chnl_map);
> -			} else {
> -				DBC_ASSERT(pattrs->strm_mode ==
> -					   STRMMODE_PROCCOPY);
> -				clear_bit(chnl_id, hnode_mgr->chnl_map);
> -			}
> +
> +		if (node1 == (struct node_object *)DSP_HGPPNODE) {
> +			node2->inputs[stream2].type = HOSTCONNECT;
> +			node2->inputs[stream2].dev_id = chnl_id;
> +			input->sz_device = pstr_dev_name;
>  		} else {
> -			clear_bit(chnl_id, hnode_mgr->chnl_map);
> -		}
> -		status = -ENOMEM;
> -func_cont2:
> -		if (!status) {
> -			if (node1 == (struct node_object *)DSP_HGPPNODE) {
> -				node2->inputs[stream2].type = HOSTCONNECT;
> -				node2->inputs[stream2].dev_id = chnl_id;
> -				input->sz_device = pstr_dev_name;
> -			} else {
> -				node1->outputs[stream1].type = HOSTCONNECT;
> -				node1->outputs[stream1].dev_id = chnl_id;
> -				output->sz_device = pstr_dev_name;
> -			}
> -			sprintf(pstr_dev_name, "%s%d", HOSTPREFIX, chnl_id);
> +			node1->outputs[stream1].type = HOSTCONNECT;
> +			node1->outputs[stream1].dev_id = chnl_id;
> +			output->sz_device = pstr_dev_name;
>  		}
> +		sprintf(pstr_dev_name, "%s%d", HOSTPREFIX, chnl_id);
>  	}
>  	/* Connecting task node to device node? */
> -	if (!status && ((node1_type == NODE_DEVICE) ||
> -				      (node2_type == NODE_DEVICE))) {
> +	if (((node1_type == NODE_DEVICE) || (node2_type == NODE_DEVICE))) {

extra set of parenthesis

>  		if (node2_type == NODE_DEVICE) {
>  			/* node1 == > device */
>  			dev_node_obj = node2;
> @@ -1098,60 +1061,57 @@ func_cont2:
>  		/* Set up create args */
>  		pstream->type = DEVICECONNECT;
>  		dw_length = strlen(dev_node_obj->pstr_dev_name);
> -		if (conn_param != NULL) {
> +		if (conn_param != NULL)
>  			pstrm_def->sz_device = kzalloc(dw_length + 1 +
> -							conn_param->cb_data,
> -							GFP_KERNEL);
> -		} else {

this else condition was removed, so in the end this code looks like:

		if (conn_param != NULL)
  			pstrm_def->sz_device = kzalloc(dw_length + 1 +
					conn_param->cb_data,
					GFP_KERNEL);
  			pstrm_def->sz_device = kzalloc(dw_length + 1,
					GFP_KERNEL);

if (conn_param) the memory will be allocated for sz_device, then
exiting the if statement, the new memory will be allocated for the
same variable leaking the previous allocation.

 Regards,

Omar
