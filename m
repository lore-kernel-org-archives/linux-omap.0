From: Sakari Ailus <sakari.ailus@iki.fi>
Subject: Re: [PATCH v2 14/15] omap3isp: Add support for the Device Tree
Date: Tue, 31 Mar 2015 00:17:27 +0300
Message-ID: <20150330211727.GE18321@valkosipuli.retiisi.org.uk>
References: <1427324259-18438-1-git-send-email-sakari.ailus@iki.fi>
 <1427324259-18438-15-git-send-email-sakari.ailus@iki.fi>
 <20150330174123.GA2658@earth>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from nblzone-211-213.nblnetworks.fi ([83.145.211.213]:38233 "EHLO
	hillosipuli.retiisi.org.uk" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1753041AbbC3VSD (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Mon, 30 Mar 2015 17:18:03 -0400
Content-Disposition: inline
In-Reply-To: <20150330174123.GA2658@earth>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>, laurent.pinchart@ideasonboard.com
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, tony@atomide.com, pali.rohar@gmail.com

Hi Sebastian,

On Mon, Mar 30, 2015 at 07:41:23PM +0200, Sebastian Reichel wrote:
> Hi,
> 
> The code crashed for me on Nokia N900. I found the following
> problem:
> 
> On Thu, Mar 26, 2015 at 12:57:38AM +0200, Sakari Ailus wrote:
> > [...]
> > +static int isp_of_parse_nodes(struct device *dev,
> > +			      struct v4l2_async_notifier *notifier)
> > +{
> > +	struct device_node *node;
> 
> struct device_node *node = NULL;
> 
> to avoid feeding a random pointer into of_graph_get_next_endpoint():

Good catch!

Laurent, could you use a new version of this patch, and send a new pull
request, or would you prefer an additional patch to fix this?

-- 
Kind regards,

Sakari Ailus
e-mail: sakari.ailus@iki.fi	XMPP: sailus@retiisi.org.uk
