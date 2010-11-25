From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [RFC/PATCH v6 03/12] media: Entities, pads and links
Date: Thu, 25 Nov 2010 13:36:50 +0000
Message-ID: <20101125133650.GA24208@opensource.wolfsonmicro.com>
References: <1290652099-15102-1-git-send-email-laurent.pinchart@ideasonboard.com>
 <1290652099-15102-4-git-send-email-laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1290652099-15102-4-git-send-email-laurent.pinchart@ideasonboard.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, sakari.ailus@maxwell.research.nokia.com, lennart@poettering.net
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 25, 2010 at 03:28:10AM +0100, Laurent Pinchart wrote:

> +Links have flags that describe the link capabilities and state.

> +	MEDIA_LINK_FLAG_ACTIVE indicates that the link is active and can be
> +	used to transfer media data. When two or more links target a sink pad,
> +	only one of them can be active at a time.

Is this supposed to reflect the current state (if the link is carrying
data right now) or if it's possible for the link to carry data?

> +struct media_entity {
> +	struct list_head list;
> +	struct media_device *parent;	/* Media device this entity belongs to*/
> +	u32 id;				/* Entity ID, unique in the parent media
> +					 * device context */
> +	const char *name;		/* Entity name */
> +	u32 type;			/* Entity type (MEDIA_ENTITY_TYPE_*) */
> +	u32 revision;			/* Entity revision, driver specific */
> +	unsigned long flags;		/* Entity flags (MEDIA_ENTITY_FLAG_*) */
> +	u32 group_id;			/* Entity group ID */
> +
> +	u16 num_pads;			/* Number of input and output pads */
> +	u16 num_links;			/* Number of existing links, both active
> +					 * and inactive */
> +	u16 num_backlinks;		/* Number of backlinks */
> +	u16 max_links;			/* Maximum number of links */
> +
> +	struct media_pad *pads;		/* Pads array (num_pads elements) */
> +	struct media_link *links;	/* Links array (max_links elements)*/

Hrm.  This is getting kind of large, especially considering the volume
of data we're holding per node and link already in ASoC.  On the other
hand we may over time be able to refactor some of the existing stuff
(especially the link management) to use this structure.
