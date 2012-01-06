From: Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>
Subject: Re: [PATCH] irqdomain: Initialize number of IRQs for simple domains
Date: Fri, 6 Jan 2012 14:34:22 -0700
Message-ID: <20120106213422.GF7457@ponder.secretlab.ca>
References: <1325860112-22051-1-git-send-email-thierry.reding@avionic-design.de>
 <CACxGe6sXmC2A0ihsK=rmQ8jQ61xcc7re=LgzPPJm8wHvvkFb4Q@mail.gmail.com>
 <20120106162016.GB5593@avionic-0098.mockup.avionic-design.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20120106162016.GB5593-RM9K5IK7kjIQXX3q8xo1gnVAuStQJXxyR5q1nwbD4aMs9pC9oP6+/A@public.gmane.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/devicetree-discuss>
List-Post: <mailto:devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>
List-Help: <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/devicetree-discuss>,
 <mailto:devicetree-discuss-request-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org?subject=subscribe>
Errors-To: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
Sender: devicetree-discuss-bounces+gldd-devicetree-discuss=m.gmane.org-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org
To: Thierry Reding <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org>
Cc: Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>, Daniel Walker <dwalker-zu3NM2574RrQT0dZR+AlfA@public.gmane.org>, Russell King <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Brown <davidb-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, "open list:ARM/QUALCOMM MSM..." <linux-arm-msm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree-discuss-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org, Rob Herring <rob.herring-bsGFqQB8/DxBDgjK7y7TUQ@public.gmane.org>, Barry Song <baohua.song-kQvG35nSl+M@public.gmane.org>, Thomas Gleixner <tglx-hfZtesqFncYOwBW4kG4KsQ@public.gmane.org>, "open list:OMAP SUPPORT" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Andrew Victor <linux-PelNFVqkFnVyf+4FbqDuWQ@public.gmane.org>, "open list:ARM/ATMEL AT91RM9..." <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, open list <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Bryan Huntsman <bryanh-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Richard Zhao <richard.zhao-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Sascha Hauer <kernel-bIcnvbaLZ9MEGnE8C9+IrQ@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Jan 06, 2012 at 05:20:16PM +0100, Thierry Reding wrote:
> * Grant Likely wrote:
> > Hi Thierry,
> > =

> > On Fri, Jan 6, 2012 at 7:28 AM, Thierry Reding
> > <thierry.reding-RM9K5IK7kjKj5M59NBduVrNAH6kLmebB@public.gmane.org> wrote:
> > > The irq_domain_add() function needs the number of interrupts in the
> > > domain to properly initialize them. In addition the allocated domain
> > > is now returned by the irq_domain_{add,generate}_simple() helpers.
> > =

> > The commit text should also include the justification for renaming
> > irq_domain_create_simple() -> irq_domain_add_simple()
> =

> Actually the commit only fixes up the comment. The function has always be=
en
> called irq_domain_add_simple().
> =

> For reference, this was introduced in commit 7e71330.

Hahaha.  Oops, you're right.  :-)

> =

> > > =A0 =A0 =A0 =A0domain =3D kzalloc(sizeof(*domain), GFP_KERNEL);
> > > - =A0 =A0 =A0 if (!domain) {
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN_ON(1);
> > > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;
> > > - =A0 =A0 =A0 }
> > > + =A0 =A0 =A0 if (!domain)
> > > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(-ENOMEM);
> > =

> > Don't use the ERR_PTR() pattern (it's a horrible pattern IMHO).
> =

> Returning NULL here is probably okay. Can the ERR_PTR stay in
> irq_domain_generate_simple(), though? It has two error conditions and
> handling both by returning NULL may not be what we want.

No.  ERR_PTR is a horrible pattern because you cannot tell by looking
at a prototype that returns a pointer whether or not the correct
failure test is "if (!ptr)" or "if (IS_ERR(ptr))".  Unless it is
absolutely critical for an error code to be returned (which isn't the
case here) I will not accept new code that uses ERR_PTR().

In this case, if irq_domain_add_simple() fails, then something is very
wrong.  I'd much rather the routine complain loudly regardless of the
error condition.

Actually, looking again at irq_domain_generate_simple() it should
probably succeed even if it cannot find a matching node since an
irq_domain does more than just device tree translation.  Although,
irq_domain_generate_simple() is a stop-gap solution that will
eventually be removed.

g.
