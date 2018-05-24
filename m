From: "Reizer, Eyal" <eyalr-l0cyMroinI0@public.gmane.org>
Subject: RE: [EXTERNAL] Re: [PATCH] wlcore: use generic runtime pm calls for
   wowlan elp configuration
Date: Thu, 24 May 2018 08:18:09 +0000
Message-ID: <06f0b1b5243a4ab7befad7b9109bf5a5@ti.com>
References: <1527146337-17562-1-git-send-email-eyalr@ti.com>
 <87fu2hiilx.fsf@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <87fu2hiilx.fsf-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>
Content-Language: en-US
Sender: linux-wireless-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Kalle Valo <kvalo-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org>, Eyal Reizer <eyalreizer-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: "tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org" <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>, "linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-wireless-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-omap-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-omap@vger.kernel.org

>=20
> > With runtime PM enabled, we can now use generic calls to
> > pm_generic_runtime_suspend and pm_generic_runtime_resume for
> enabling elp
> > during suspend when wowlan is enabled and waking the chip from elp
> > on resume.
> > remove the custom API that was used to ensure that the command
> > that is used to allow ELP during suspend is completed before the system
> > suspend.
> >
> > Signed-off-by: Eyal Reizer <eyalr-l0cyMroinI0@public.gmane.org>
> > ---
> > Dependent on the Runtime PM support for wlcore patch set that was
> submitted
> > by Tony Lindgren <tony-4v6yS6AI5VpBDgjK7y7TUQ@public.gmane.org>
>=20
> Ok, I'll drop this from my queue. Please resubmit once Tony's patches
> are ready to apply (or Tony can include this patch in his patchset).
>=20
> BTW, for me it would be a lot easier if you could mark patches like this
> as RFT (Request For Test) or RFC (Request For Comments). That way I can
> automatically drop the patch without sending any emails.
>=20

Understood. Thanks!

Best Regards,
Eyal
