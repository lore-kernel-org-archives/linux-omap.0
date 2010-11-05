From: Ionut Nicu <ionut.nicu@gmail.com>
Subject: [PATCH v2 12/12] staging: tidspbridge: rmgr code cleanup
Date: Fri,  5 Nov 2010 17:13:16 +0200
Message-ID: <1288969996-22103-13-git-send-email-ionut.nicu@mindbit.ro>
References: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:44531 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753297Ab0KEPOh (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 5 Nov 2010 11:14:37 -0400
Received: by gxk23 with SMTP id 23so2221624gxk.19
        for <linux-omap@vger.kernel.org>; Fri, 05 Nov 2010 08:14:36 -0700 (PDT)
In-Reply-To: <1288969996-22103-1-git-send-email-ionut.nicu@mindbit.ro>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Greg Kroah-Hartman <greg@kroah.com>, Omar Ramirez Luna <omar.ramirez@ti.com>
Cc: Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Sapiens Rene <rene.sapiens@ti.com>, linux-omap <linux-omap@vger.kernel.org>, Ionut Nicu <ionut.nicu@mindbit.ro>

Reorganized some code in the rmgr module to increase
its readability. No functional changes were done.

Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
---
 drivers/staging/tidspbridge/rmgr/drv.c  |  171 +++++++++-----------
 drivers/staging/tidspbridge/rmgr/node.c |   82 +++++-----
 drivers/staging/tidspbridge/rmgr/rmm.c  |  267 +++++++++++++------------------
 3 files changed, 229 insertions(+), 291 deletions(-)

diff --git a/drivers/staging/tidspbridge/rmgr/drv.c b/drivers/staging/tidspbridge/rmgr/drv.c
index 18fae55..4eff419 100644
--- a/drivers/staging/tidspbridge/rmgr/drv.c
+++ b/drivers/staging/tidspbridge/rmgr/drv.c
@@ -293,40 +293,28 @@ int drv_proc_update_strm_res(u32 num_bufs, void *strm_resources)
  */
 int drv_create(struct drv_object **drv_obj)
 {
-	int status = 0;
 	struct drv_object *pdrv_object = NULL;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
 	DBC_REQUIRE(drv_obj != NULL);
 	DBC_REQUIRE(refs > 0);
 
+	if (!drv_datap)
+		return -EFAULT;
+
 	pdrv_object = kzalloc(sizeof(struct drv_object), GFP_KERNEL);
-	if (pdrv_object) {
-		/* Create and Initialize List of device objects */
-		INIT_LIST_HEAD(&pdrv_object->dev_list);
-		INIT_LIST_HEAD(&pdrv_object->dev_node_string);
-	} else {
-		status = -ENOMEM;
-	}
-	/* Store the DRV Object in the driver data */
-	if (!status) {
-		if (drv_datap) {
-			drv_datap->drv_object = (void *)pdrv_object;
-		} else {
-			status = -EPERM;
-			pr_err("%s: Failed to store DRV object\n", __func__);
-		}
-	}
+	if (!pdrv_object)
+		return -ENOMEM;
 
-	if (!status) {
-		*drv_obj = pdrv_object;
-	} else {
-		/* Free the DRV Object */
-		kfree(pdrv_object);
-	}
+	/* Create and Initialize List of device objects */
+	INIT_LIST_HEAD(&pdrv_object->dev_list);
+	INIT_LIST_HEAD(&pdrv_object->dev_node_string);
 
-	DBC_ENSURE(status || pdrv_object);
-	return status;
+	/* Store the DRV Object in the driver data */
+	drv_datap->drv_object = (void *)pdrv_object;
+	*drv_obj = pdrv_object;
+
+	return 0;
 }
 
 /*
@@ -413,19 +401,19 @@ int drv_get_dev_object(u32 index, struct drv_object *hdrv_obj,
  */
 u32 drv_get_first_dev_object(void)
 {
-	u32 dw_dev_object = 0;
 	struct drv_object *pdrv_obj;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
-	if (drv_datap && drv_datap->drv_object) {
-		pdrv_obj = drv_datap->drv_object;
-		if (!list_empty(&pdrv_obj->dev_list))
-			dw_dev_object = (u32) pdrv_obj->dev_list.next;
-	} else {
+	if (!drv_datap || !drv_datap->drv_object) {
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
+		return 0;
 	}
 
-	return dw_dev_object;
+	pdrv_obj = drv_datap->drv_object;
+	if (list_empty(&pdrv_obj->dev_list))
+		return 0;
+
+	return (u32) pdrv_obj->dev_list.next;
 }
 
 /*
@@ -436,21 +424,19 @@ u32 drv_get_first_dev_object(void)
  */
 u32 drv_get_first_dev_extension(void)
 {
-	u32 dw_dev_extension = 0;
 	struct drv_object *pdrv_obj;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 
-	if (drv_datap && drv_datap->drv_object) {
-		pdrv_obj = drv_datap->drv_object;
-		if (!list_empty(&pdrv_obj->dev_node_string)) {
-			dw_dev_extension =
-			    (u32) pdrv_obj->dev_node_string.next;
-		}
-	} else {
+	if (!drv_datap || !drv_datap->drv_object) {
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
+		return 0;
 	}
 
-	return dw_dev_extension;
+	pdrv_obj = drv_datap->drv_object;
+	if (list_empty(&pdrv_obj->dev_node_string))
+		return 0;
+
+	return (u32) pdrv_obj->dev_node_string.next;
 }
 
 /*
@@ -462,26 +448,27 @@ u32 drv_get_first_dev_extension(void)
  */
 u32 drv_get_next_dev_object(u32 hdev_obj)
 {
-	u32 dw_next_dev_object = 0;
 	struct drv_object *pdrv_obj;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 	struct list_head *curr;
 
 	DBC_REQUIRE(hdev_obj != 0);
 
-	if (drv_datap && drv_datap->drv_object) {
-		pdrv_obj = drv_datap->drv_object;
-		if (!list_empty(&pdrv_obj->dev_list)) {
-			curr = (struct list_head *)hdev_obj;
-			if (curr->next == &pdrv_obj->dev_list)
-				return 0;
-			dw_next_dev_object = (u32) curr->next;
-		}
-	} else {
+	if (!drv_datap || !drv_datap->drv_object) {
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
+		return 0;
 	}
 
-	return dw_next_dev_object;
+	pdrv_obj = drv_datap->drv_object;
+	if (list_empty(&pdrv_obj->dev_list))
+		return 0;
+
+	curr = (struct list_head *)hdev_obj;
+
+	if (curr->next == &pdrv_obj->dev_list)
+		return 0;
+
+	return (u32)curr->next;
 }
 
 /*
@@ -494,26 +481,27 @@ u32 drv_get_next_dev_object(u32 hdev_obj)
  */
 u32 drv_get_next_dev_extension(u32 dev_extension)
 {
-	u32 dw_dev_extension = 0;
 	struct drv_object *pdrv_obj;
 	struct drv_data *drv_datap = dev_get_drvdata(bridge);
 	struct list_head *curr;
 
 	DBC_REQUIRE(dev_extension != 0);
 
-	if (drv_datap && drv_datap->drv_object) {
-		pdrv_obj = drv_datap->drv_object;
-		if (!list_empty(&pdrv_obj->dev_node_string)) {
-			curr = (struct list_head *)dev_extension;
-			if (curr->next == &pdrv_obj->dev_node_string)
-				return 0;
-			dw_dev_extension = (u32) curr->next;
-		}
-	} else {
+	if (!drv_datap || !drv_datap->drv_object) {
 		pr_err("%s: Failed to retrieve the object handle\n", __func__);
+		return 0;
 	}
 
-	return dw_dev_extension;
+	pdrv_obj = drv_datap->drv_object;
+	if (list_empty(&pdrv_obj->dev_node_string))
+		return 0;
+
+	curr = (struct list_head *)dev_extension;
+
+	if (curr->next == &pdrv_obj->dev_node_string)
+		return 0;
+
+	return (u32) curr->next;
 }
 
 /*
@@ -601,40 +589,28 @@ int drv_request_resources(u32 dw_context, u32 *dev_node_strg)
 	DBC_REQUIRE(dw_context != 0);
 	DBC_REQUIRE(dev_node_strg != NULL);
 
-	/*
-	 *  Allocate memory to hold the string. This will live untill
-	 *  it is freed in the Release resources. Update the driver object
-	 *  list.
-	 */
-
 	if (!drv_datap || !drv_datap->drv_object)
-		status = -ENODATA;
-	else
-		pdrv_object = drv_datap->drv_object;
-
-	if (!status) {
-		pszdev_node = kzalloc(sizeof(struct drv_ext), GFP_KERNEL);
-		if (pszdev_node) {
-			strncpy(pszdev_node->sz_string,
-				(char *)dw_context, MAXREGPATHLENGTH - 1);
-			pszdev_node->sz_string[MAXREGPATHLENGTH - 1] = '\0';
-			/* Update the Driver Object List */
-			*dev_node_strg = (u32) pszdev_node->sz_string;
-			list_add_tail(&pszdev_node->link,
-					&pdrv_object->dev_node_string);
-		} else {
-			status = -ENOMEM;
-			*dev_node_strg = 0;
-		}
-	} else {
-		dev_dbg(bridge, "%s: Failed to get Driver Object from Registry",
-			__func__);
-		*dev_node_strg = 0;
-	}
+		return -ENODATA;
+
+	pdrv_object = drv_datap->drv_object;
+	*dev_node_strg = 0;
+
+	pszdev_node = kzalloc(sizeof(struct drv_ext), GFP_KERNEL);
+	if (!pszdev_node)
+		return -ENOMEM;
+
+	strncpy(pszdev_node->sz_string, (char *)dw_context,
+			MAXREGPATHLENGTH - 1);
+	pszdev_node->sz_string[MAXREGPATHLENGTH - 1] = '\0';
+	*dev_node_strg = (u32) pszdev_node->sz_string;
+
+	/* Update the Driver Object List */
+	list_add_tail((struct list_head *)pszdev_node,
+			&pdrv_object->dev_node_string);
 
 	DBC_ENSURE((!status && dev_node_strg != NULL &&
-		    !list_empty(&pdrv_object->dev_node_string)) ||
-		   (status && *dev_node_strg == 0));
+				!list_empty(&pdrv_object->dev_node_string)) ||
+			(status && *dev_node_strg == 0));
 
 	return status;
 }
@@ -646,7 +622,6 @@ int drv_request_resources(u32 dw_context, u32 *dev_node_strg)
  */
 int drv_release_resources(u32 dw_context, struct drv_object *hdrv_obj)
 {
-	int status = 0;
 	struct drv_ext *pszdev_node;
 
 	/*
@@ -659,12 +634,12 @@ int drv_release_resources(u32 dw_context, struct drv_object *hdrv_obj)
 		if ((u32) pszdev_node == dw_context) {
 			/* Found it */
 			/* Delete from the Driver object list */
-			list_del(&pszdev_node->link);
-			kfree(pszdev_node);
+			list_del((struct list_head *)pszdev_node);
+			kfree((void *)pszdev_node);
 			break;
 		}
 	}
-	return status;
+	return 0;
 }
 
 /*
diff --git a/drivers/staging/tidspbridge/rmgr/node.c b/drivers/staging/tidspbridge/rmgr/node.c
index 34ae0ad..23775fd 100644
--- a/drivers/staging/tidspbridge/rmgr/node.c
+++ b/drivers/staging/tidspbridge/rmgr/node.c
@@ -1554,27 +1554,26 @@ int node_enum_nodes(struct node_mgr *hnode_mgr, void **node_tab,
 	DBC_REQUIRE(pu_num_nodes != NULL);
 	DBC_REQUIRE(pu_allocated != NULL);
 
-	if (!hnode_mgr) {
-		status = -EFAULT;
-		goto func_end;
-	}
-	/* Enter critical section */
+	if (!hnode_mgr)
+		return -EFAULT;
+
 	mutex_lock(&hnode_mgr->node_mgr_lock);
 
 	if (hnode_mgr->num_nodes > node_tab_size) {
 		*pu_allocated = hnode_mgr->num_nodes;
 		*pu_num_nodes = 0;
 		status = -EINVAL;
-	} else {
-		i = 0;
-		list_for_each_entry(hnode, &hnode_mgr->node_list, list_elem)
-			node_tab[i++] = hnode;
-		*pu_allocated = *pu_num_nodes = hnode_mgr->num_nodes;
+		goto out_unlock;
 	}
-	/* end of sync_enter_cs */
-	/* Exit critical section */
+
+	i = 0;
+	list_for_each_entry(hnode, &hnode_mgr->node_list, list_elem) {
+		DBC_ASSERT(hnode);
+		node_tab[i++] = hnode;
+	}
+	*pu_allocated = *pu_num_nodes = hnode_mgr->num_nodes;
+out_unlock:
 	mutex_unlock(&hnode_mgr->node_mgr_lock);
-func_end:
 	return status;
 }
 
@@ -1657,8 +1656,7 @@ int node_get_attr(struct node_object *hnode,
 	mutex_lock(&hnode_mgr->node_mgr_lock);
 	pattr->cb_struct = sizeof(struct dsp_nodeattr);
 	/* dsp_nodeattrin */
-	pattr->in_node_attr_in.cb_struct =
-		sizeof(struct dsp_nodeattrin);
+	pattr->in_node_attr_in.cb_struct = sizeof(struct dsp_nodeattrin);
 	pattr->in_node_attr_in.prio = hnode->prio;
 	pattr->in_node_attr_in.utimeout = hnode->utimeout;
 	pattr->in_node_attr_in.heap_size =
@@ -2540,38 +2538,40 @@ static void delete_node_mgr(struct node_mgr *hnode_mgr)
 {
 	struct node_object *hnode, *tmp;
 
-	if (hnode_mgr) {
-		/* Free resources */
-		if (hnode_mgr->hdcd_mgr)
-			dcd_destroy_manager(hnode_mgr->hdcd_mgr);
+	if (!hnode_mgr)
+		return;
 
-		/* Remove any elements remaining in lists */
-		list_for_each_entry_safe(hnode, tmp, &hnode_mgr->node_list,
-				list_elem) {
-			list_del(&hnode->list_elem);
-			delete_node(hnode, NULL);
-		}
-		mutex_destroy(&hnode_mgr->node_mgr_lock);
-		if (hnode_mgr->ntfy_obj) {
-			ntfy_delete(hnode_mgr->ntfy_obj);
-			kfree(hnode_mgr->ntfy_obj);
-		}
+	/* Free resources */
+	if (hnode_mgr->hdcd_mgr)
+		dcd_destroy_manager(hnode_mgr->hdcd_mgr);
 
-		if (hnode_mgr->disp_obj)
-			disp_delete(hnode_mgr->disp_obj);
+	/* Remove any elements remaining in lists */
+	list_for_each_entry_safe(hnode, tmp, &hnode_mgr->node_list, list_elem) {
+		list_del(&hnode->list_elem);
+		delete_node(hnode, NULL);
+	}
 
-		if (hnode_mgr->strm_mgr_obj)
-			strm_delete(hnode_mgr->strm_mgr_obj);
+	mutex_destroy(&hnode_mgr->node_mgr_lock);
 
-		/* Delete the loader */
-		if (hnode_mgr->nldr_obj)
-			hnode_mgr->nldr_fxns.pfn_delete(hnode_mgr->nldr_obj);
+	if (hnode_mgr->ntfy_obj) {
+		ntfy_delete(hnode_mgr->ntfy_obj);
+		kfree(hnode_mgr->ntfy_obj);
+	}
 
-		if (hnode_mgr->loader_init)
-			hnode_mgr->nldr_fxns.pfn_exit();
+	if (hnode_mgr->disp_obj)
+		disp_delete(hnode_mgr->disp_obj);
 
-		kfree(hnode_mgr);
-	}
+	if (hnode_mgr->strm_mgr_obj)
+		strm_delete(hnode_mgr->strm_mgr_obj);
+
+	/* Delete the loader */
+	if (hnode_mgr->nldr_obj)
+		hnode_mgr->nldr_fxns.pfn_delete(hnode_mgr->nldr_obj);
+
+	if (hnode_mgr->loader_init)
+		hnode_mgr->nldr_fxns.pfn_exit();
+
+	kfree(hnode_mgr);
 }
 
 /*
diff --git a/drivers/staging/tidspbridge/rmgr/rmm.c b/drivers/staging/tidspbridge/rmgr/rmm.c
index 93db337..9d673f5 100644
--- a/drivers/staging/tidspbridge/rmgr/rmm.c
+++ b/drivers/staging/tidspbridge/rmgr/rmm.c
@@ -96,10 +96,9 @@ static bool free_block(struct rmm_target_obj *target, u32 segid, u32 addr,
 int rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
 		     u32 align, u32 *dsp_address, bool reserve)
 {
-	struct rmm_ovly_sect *sect, *prev_sect = NULL;
+	struct rmm_ovly_sect *sect, *prev = NULL;
 	struct rmm_ovly_sect *new_sect;
 	u32 addr;
-	int status = 0;
 
 	DBC_REQUIRE(target);
 	DBC_REQUIRE(dsp_address != NULL);
@@ -108,54 +107,38 @@ int rmm_alloc(struct rmm_target_obj *target, u32 segid, u32 size,
 	DBC_REQUIRE(refs > 0);
 
 	if (!reserve) {
-		if (!alloc_block(target, segid, size, align, dsp_address)) {
-			status = -ENOMEM;
-		} else {
-			/* Increment the number of allocated blocks in this
-			 * segment */
-			target->seg_tab[segid].number++;
-		}
-		goto func_end;
+		if (!alloc_block(target, segid, size, align, dsp_address))
+			return -ENOMEM;
+		/* Increment the number of allocated blocks in this segment */
+		target->seg_tab[segid].number++;
+		return 0;
 	}
+
+	new_sect = kzalloc(sizeof(struct rmm_ovly_sect), GFP_KERNEL);
+	if (!new_sect)
+		return -ENOMEM;
+
+	addr = *dsp_address;
+	new_sect->addr = addr;
+	new_sect->size = size;
+	new_sect->page = segid;
+
 	/* An overlay section - See if block is already in use. If not,
 	 * insert into the list in ascending address size. */
-	addr = *dsp_address;
-	/*  Find place to insert new list element. List is sorted from
-	 *  smallest to largest address. */
 	list_for_each_entry(sect, &target->ovly_list, list_elem) {
 		if (addr <= sect->addr) {
-			/* Check for overlap with sect */
-			if ((addr + size > sect->addr) || (prev_sect &&
-							   (prev_sect->addr +
-							    prev_sect->size >
-							    addr))) {
-				status = -ENXIO;
+			if (prev && (prev->addr + prev->size >  addr)) {
+				kfree(new_sect);
+				return -ENXIO;
 			}
-			break;
-		}
-		prev_sect = sect;
-	}
-	if (!status) {
-		/* No overlap - allocate list element for new section. */
-		new_sect = kzalloc(sizeof(struct rmm_ovly_sect), GFP_KERNEL);
-		if (new_sect == NULL) {
-			status = -ENOMEM;
-		} else {
-			new_sect->addr = addr;
-			new_sect->size = size;
-			new_sect->page = segid;
-			if (sect == NULL)
-				/* Put new section at the end of the list */
-				list_add_tail(&new_sect->list_elem,
-						&target->ovly_list);
-			else
-				/* Put new section just before sect */
-				list_add_tail(&new_sect->list_elem,
-						&sect->list_elem);
+			list_add_tail(&new_sect->list_elem, &sect->list_elem);
+			return 0;
 		}
+		prev = sect;
 	}
-func_end:
-	return status;
+	list_add_tail(&new_sect->list_elem, &target->ovly_list);
+
+	return 0;
 }
 
 /*
@@ -173,71 +156,57 @@ int rmm_create(struct rmm_target_obj **target_obj,
 	DBC_REQUIRE(target_obj != NULL);
 	DBC_REQUIRE(num_segs == 0 || seg_tab != NULL);
 
+	if (num_segs <= 0)
+		return -EINVAL;
+
 	/* Allocate DBL target object */
 	target = kzalloc(sizeof(struct rmm_target_obj), GFP_KERNEL);
-
-	if (target == NULL)
-		status = -ENOMEM;
-
-	if (status)
-		goto func_cont;
+	if (!target)
+		return -ENOMEM;
 
 	target->num_segs = num_segs;
-	if (!(num_segs > 0))
-		goto func_cont;
-
+	INIT_LIST_HEAD(&target->ovly_list);
 	/* Allocate the memory for freelist from host's memory */
-	target->free_list = kzalloc(num_segs * sizeof(struct rmm_header *),
-							GFP_KERNEL);
-	if (target->free_list == NULL) {
+	target->free_list = kzalloc(num_segs *
+			sizeof(struct rmm_header *), GFP_KERNEL);
+	if (!target->free_list) {
 		status = -ENOMEM;
-	} else {
-		/* Allocate headers for each element on the free list */
-		for (i = 0; i < (s32) num_segs; i++) {
-			target->free_list[i] =
-				kzalloc(sizeof(struct rmm_header), GFP_KERNEL);
-			if (target->free_list[i] == NULL) {
-				status = -ENOMEM;
-				break;
-			}
-		}
-		/* Allocate memory for initial segment table */
-		target->seg_tab = kzalloc(num_segs * sizeof(struct rmm_segment),
-								GFP_KERNEL);
-		if (target->seg_tab == NULL) {
+		goto out_err;
+	}
+	/* Allocate headers for each element on the free list */
+	for (i = 0; i < num_segs; i++) {
+		target->free_list[i] =
+			kzalloc(sizeof(struct rmm_header), GFP_KERNEL);
+		if (!target->free_list[i]) {
 			status = -ENOMEM;
-		} else {
-			/* Initialize segment table and free list */
-			sptr = target->seg_tab;
-			for (i = 0, tmp = seg_tab; num_segs > 0;
-			     num_segs--, i++) {
-				*sptr = *tmp;
-				hptr = target->free_list[i];
-				hptr->addr = tmp->base;
-				hptr->size = tmp->length;
-				hptr->next = NULL;
-				tmp++;
-				sptr++;
-			}
+			goto out_err;
 		}
 	}
-func_cont:
-	/* Initialize overlay memory list */
-	if (!status)
-		INIT_LIST_HEAD(&target->ovly_list);
-
-	if (!status) {
-		*target_obj = target;
-	} else {
-		*target_obj = NULL;
-		if (target)
-			rmm_delete(target);
-
+	/* Allocate memory for initial segment table */
+	target->seg_tab = kzalloc(num_segs * sizeof(struct rmm_segment),
+			GFP_KERNEL);
+	if (!target->seg_tab) {
+		status = -ENOMEM;
+		goto out_err;
+	}
+	/* Initialize segment table and free list */
+	sptr = target->seg_tab;
+	for (i = 0, tmp = seg_tab; num_segs > 0; num_segs--, i++) {
+		*sptr = *tmp;
+		hptr = target->free_list[i];
+		hptr->addr = tmp->base;
+		hptr->size = tmp->length;
+		hptr->next = NULL;
+		tmp++;
+		sptr++;
 	}
 
-	DBC_ENSURE((!status && *target_obj)
-		   || (status && *target_obj == NULL));
+	*target_obj = target;
 
+	return 0;
+out_err:
+	*target_obj = NULL;
+	rmm_delete(target);
 	return status;
 }
 
@@ -298,14 +267,12 @@ bool rmm_free(struct rmm_target_obj *target, u32 segid, u32 dsp_addr, u32 size,
 	bool ret = false;
 
 	DBC_REQUIRE(target);
-
 	DBC_REQUIRE(reserved || segid < target->num_segs);
 	DBC_REQUIRE(reserved || (dsp_addr >= target->seg_tab[segid].base &&
-				 (dsp_addr + size) <= (target->seg_tab[segid].
-						   base +
-						   target->seg_tab[segid].
-						   length)));
-
+				(dsp_addr + size) <= (target->seg_tab[segid].
+					base +
+					target->seg_tab[segid].
+					length)));
 	/*
 	 *  Free or unreserve memory.
 	 */
@@ -313,21 +280,20 @@ bool rmm_free(struct rmm_target_obj *target, u32 segid, u32 dsp_addr, u32 size,
 		ret = free_block(target, segid, dsp_addr, size);
 		if (ret)
 			target->seg_tab[segid].number--;
+		return ret;
+	}
 
-	} else {
-		/* Unreserve memory */
-		list_for_each_entry_safe(sect, tmp, &target->ovly_list,
-				list_elem) {
-			if (dsp_addr == sect->addr) {
-				DBC_ASSERT(size == sect->size);
-				/* Remove from list */
-				list_del(&sect->list_elem);
-				kfree(sect);
-				ret = true;
-				break;
-			}
+	/* Unreserve memory */
+	list_for_each_entry_safe(sect, tmp, &target->ovly_list, list_elem) {
+		if (sect->addr == dsp_addr) {
+			DBC_ASSERT(size == sect->size);
+			/* Remove from list */
+			list_del(&sect->list_elem);
+			kfree(sect);
+			break;
 		}
 	}
+
 	return ret;
 }
 
@@ -463,51 +429,48 @@ static bool free_block(struct rmm_target_obj *target, u32 segid, u32 addr,
 	struct rmm_header *head;
 	struct rmm_header *thead;
 	struct rmm_header *rhead;
-	bool ret = true;
 
 	/* Create a memory header to hold the newly free'd block. */
 	rhead = kzalloc(sizeof(struct rmm_header), GFP_KERNEL);
-	if (rhead == NULL) {
-		ret = false;
-	} else {
-		/* search down the free list to find the right place for addr */
-		head = target->free_list[segid];
+	if (!rhead)
+		return false;
 
-		if (addr >= head->addr) {
-			while (head->next != NULL && addr > head->next->addr)
-				head = head->next;
-
-			thead = head->next;
-
-			head->next = rhead;
-			rhead->next = thead;
-			rhead->addr = addr;
-			rhead->size = size;
-		} else {
-			*rhead = *head;
-			head->next = rhead;
-			head->addr = addr;
-			head->size = size;
-			thead = rhead->next;
-		}
+	/* search down the free list to find the right place for addr */
+	head = target->free_list[segid];
 
-		/* join with upper block, if possible */
-		if (thead != NULL && (rhead->addr + rhead->size) ==
-		    thead->addr) {
-			head->next = rhead->next;
-			thead->size = size + thead->size;
-			thead->addr = addr;
-			kfree(rhead);
-			rhead = thead;
-		}
+	if (addr >= head->addr) {
+		while (head->next != NULL && addr > head->next->addr)
+			head = head->next;
 
-		/* join with the lower block, if possible */
-		if ((head->addr + head->size) == rhead->addr) {
-			head->next = rhead->next;
-			head->size = head->size + rhead->size;
-			kfree(rhead);
-		}
+		thead = head->next;
+		head->next = rhead;
+		rhead->next = thead;
+		rhead->addr = addr;
+		rhead->size = size;
+	} else {
+		*rhead = *head;
+		head->next = rhead;
+		head->addr = addr;
+		head->size = size;
+		thead = rhead->next;
 	}
 
-	return ret;
+	/* join with upper block, if possible */
+	if (thead != NULL && (rhead->addr + rhead->size) ==
+			thead->addr) {
+		head->next = rhead->next;
+		thead->size = size + thead->size;
+		thead->addr = addr;
+		kfree(rhead);
+		rhead = thead;
+	}
+
+	/* join with the lower block, if possible */
+	if ((head->addr + head->size) == rhead->addr) {
+		head->next = rhead->next;
+		head->size = head->size + rhead->size;
+		kfree(rhead);
+	}
+
+	return true;
 }
-- 
1.7.2.3

