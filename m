From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] omapfb/dss: Delete an error message for a failed memory
 allocation in three functions
Date: Mon, 27 Nov 2017 11:07:13 -0800
Message-ID: <1511809633.32426.70.camel@perches.com>
References: <c48a01db-c477-3bd3-5cb4-548e47810ccb@users.sourceforge.net>
         <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d29a0bae-7b6f-b8f6-6809-5a097cd5a26a@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Andrew F. Davis" <afd@ti.com>, SF Markus Elfring <elfring@users.sourceforge.net>, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, dri-devel@lists.freedesktop.org, Arvind Yadav <arvind.yadav.cs@gmail.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Tomi Valkeinen <tomi.valkeinen@ti.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Mon, 2017-11-27 at 10:43 -0600, Andrew F. Davis wrote:
> On 11/26/2017 12:55 PM, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sun, 26 Nov 2017 19:46:09 +0100
> > 
> > Omit an extra message for a memory allocation failure in these functions.
> > 
> > This issue was detected by using the Coccinelle software.
> > 
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> > ---
> 
> nak, unlike many others, these message give extra info on which
> allocation failed, that can be useful.

<shrug>  Not really.  There are tradeoffs.

There is the generic stack dump on OOM so the module/line
is already known.

The existence of these messages increases code size which
also make the OOM condition slightly more likely.

These are generally used only at initialization and those
if you are OOM at initialization, bad things happen anyway
so where the specific OOM occurred doesn't really matter.

Markus' commit messages are always really poor descriptions
of why these removals are somewhat useful and the commit
could/should/might be applied.

Your choice.

> >  drivers/video/fbdev/omap2/omapfb/dss/dispc.c    | 4 +---
> >  drivers/video/fbdev/omap2/omapfb/dss/dss.c      | 4 +---
> >  drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c | 4 +---
> >  3 files changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> > index 7a75dfda9845..10164a3bae4a 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/dispc.c
> > @@ -3982,10 +3982,8 @@ static int dispc_init_features(struct platform_device *pdev)
> >  	struct dispc_features *dst;
> >  
> >  	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
> > -	if (!dst) {
> > -		dev_err(&pdev->dev, "Failed to allocate DISPC Features\n");
> > +	if (!dst)
> >  		return -ENOMEM;
> > -	}
> >  
> >  	switch (omapdss_get_version()) {
> >  	case OMAPDSS_VER_OMAP24xx:
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/dss.c b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> > index 48c6500c24e1..a5de13777e2b 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/dss.c
> > @@ -893,10 +893,8 @@ static int dss_init_features(struct platform_device *pdev)
> >  	struct dss_features *dst;
> >  
> >  	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
> > -	if (!dst) {
> > -		dev_err(&pdev->dev, "Failed to allocate local DSS Features\n");
> > +	if (!dst)
> >  		return -ENOMEM;
> > -	}
> >  
> >  	switch (omapdss_get_version()) {
> >  	case OMAPDSS_VER_OMAP24xx:
> > diff --git a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> > index 9a13c35fd6d8..d25eea10c665 100644
> > --- a/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> > +++ b/drivers/video/fbdev/omap2/omapfb/dss/hdmi_phy.c
> > @@ -195,10 +195,8 @@ static int hdmi_phy_init_features(struct platform_device *pdev)
> >  	const struct hdmi_phy_features *src;
> >  
> >  	dst = devm_kzalloc(&pdev->dev, sizeof(*dst), GFP_KERNEL);
> > -	if (!dst) {
> > -		dev_err(&pdev->dev, "Failed to allocate HDMI PHY Features\n");
> > +	if (!dst)
> >  		return -ENOMEM;
> > -	}
> >  
> >  	switch (omapdss_get_version()) {
> >  	case OMAPDSS_VER_OMAP4430_ES1:
> > 
