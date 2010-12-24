From: Ionut Nicu <ionut.nicu@mindbit.ro>
Subject: Re: [PATCH 2/2] staging: tidspbridge: rmgr code cleanup
Date: Fri, 24 Dec 2010 13:33:38 +0200
Message-ID: <1293190418.9114.5.camel@atlantis.mindbit.ro>
References: <1291931258-30744-1-git-send-email-ionut.nicu@mindbit.ro>
	 <1291931258-30744-3-git-send-email-ionut.nicu@mindbit.ro>
	 <AANLkTikMD-pEQNNNKOx+1kZt=y896Ciz_kU60NsNzhGJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from ns.mindbit.ro ([80.86.127.26]:41814 "EHLO ns.mindbit.ro"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751944Ab0LXLdz (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Fri, 24 Dec 2010 06:33:55 -0500
In-Reply-To: <AANLkTikMD-pEQNNNKOx+1kZt=y896Ciz_kU60NsNzhGJ@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Cc: Greg Kroah-Hartman <greg@kroah.com>, Sapiens Rene <rene.sapiens@ti.com>, Andy Shevchenko <andy.shevchenko@gmail.com>, Fernando Guzman Lugo <x0095840@ti.com>, Felipe Contreras <felipe.contreras@gmail.com>, linux-omap <linux-omap@vger.kernel.org>

Hi Omar,

On Wed, 2010-12-22 at 14:52 -0600, Ramirez Luna, Omar wrote:
> Hi Ionut,
> 
> On Thu, Dec 9, 2010 at 3:47 PM, Ionut Nicu <ionut.nicu@gmail.com> wrote:
> > Reorganized some code in the rmgr module to increase
> > its readability. No functional changes were done.
> >
> > Signed-off-by: Ionut Nicu <ionut.nicu@mindbit.ro>
> > ---
> >  drivers/staging/tidspbridge/rmgr/drv.c  |  171 +++++++++-----------
> >  drivers/staging/tidspbridge/rmgr/node.c |   81 +++++-----
> >  drivers/staging/tidspbridge/rmgr/rmm.c  |  266 +++++++++++++-----------------
> >  3 files changed, 229 insertions(+), 289 deletions(-)
> >
> > +
> > +       /* Update the Driver Object List */
> > +       list_add_tail((struct list_head *)pszdev_node,
> > +                       &pdrv_object->dev_node_string);
> 
> I'm not quite comfortable casting to list_head ptr, given that there
> is already a member of that type, if the struct type of pszdev_node is
> moved around and the first member changes, there should be issues.
> 
> Any reason to use them in this patch?
> 

You are right, it's useless and error prone. I will fix this and the
other occurrences.

Regards,
Ionut.

