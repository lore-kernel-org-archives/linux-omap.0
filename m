From: Tomi Valkeinen <tomi.valkeinen@nokia.com>
Subject: RE: [RFC][PATCH 3/8] OMAP: DSS2: Modify dss_recheck_connections
Date: Thu, 01 Jul 2010 16:12:34 +0300
Message-ID: <1277989954.2474.333.camel@tubuntu.research.nokia.com>
References: <1277980285-20996-1-git-send-email-archit@ti.com>
	 <1277980285-20996-2-git-send-email-archit@ti.com>
	 <1277980285-20996-3-git-send-email-archit@ti.com>
	 <1277980285-20996-4-git-send-email-archit@ti.com>
	 <1277983917.2474.319.camel@tubuntu.research.nokia.com>
	 <FCCFB4CDC6E5564B9182F639FC3560870305A419C2@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp.nokia.com ([192.100.122.233]:23527 "EHLO
	mgw-mx06.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab0GANNJ (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 1 Jul 2010 09:13:09 -0400
In-Reply-To: <FCCFB4CDC6E5564B9182F639FC3560870305A419C2@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "ext Taneja, Archit" <archit@ti.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Semwal, Sumit" <sumit.semwal@ti.com>, "Guruswamy, Senthilvadivu" <svadivu@ti.com>, "Mittal, Mukund" <mmittal@ti.com>, "Nilofer, Samreen" <samreen@ti.com>

On Thu, 2010-07-01 at 14:28 +0200, ext Taneja, Archit wrote:
> > On Thu, 2010-07-01 at 12:31 +0200, ext Archit Taneja wrote:
> > > From: Sumit Semwal <sumit.semwal@ti.com>
> > > 
> > > The addition of the new 2lcd manager requires modifications in the 
> > > dss_recheck_connections patch, this function behaves the 
> > same if the 
> > > 2lcd manager doesn't exist
> > 
> > Here (and also in the previous patch) you talk about 2lcd, 
> > but the code uses lcd2.
> 
> Archit:  The new manager's name defined in manager.c is 2lcd,
> The channel's name in the enum is OMAP_DSS_CHANNEL_LCD2, and
> the overlay manager enum is OMAP_DSS_OVL_MGR_LCD2.
> 
> 2lcd as the manager name was taken so that no one makes mistakes
> while reading/writing sysfs entries.
> 
> Also, in the dss2 code we use strncmp() to compare the manager
> names in overlay_manager_store(). Now, if we name the new manager
> as "lcd2", consider the following scenario:
> 
> Suppose an overlay has its manager presently set as "lcd2". Now
> someone does a sysfs entry to make the manager as "lcd". So in this
> case the variable buf is "lcd" and and mgr->name is "lcd2". The
> variable len is calculated on the basis of buf ("lcd") as 3.
> 
> So strncmp just compares the first 3 chars, and in that case "lcd"
> and "lcd2" are the same, luckily this doesn't cause an issue as the
> first manager fetched by omap_dss_get_overlay_manager() is "lcd". If
> the manager_list was filled in some other way then this would have
> resulted an issue.

If the DSS sysfs code if broken, let's rather fix it than name the
manager with a rather strange name, just to circumvent a bug.

> 
> In my opinion, len should be calculated as:
> 
> len = max(len, strlen(mgr->name));
> 
> This way strncmp would work correctly in all the cases.

sysfs_streq() could be used there.

 Tomi


