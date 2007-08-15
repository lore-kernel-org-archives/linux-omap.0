From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 8/8] musb_hdrc: Tabify and clean-up musbhdrc.h
Date: Wed, 15 Aug 2007 09:20:46 -0700
Message-ID: <200708150920.46534.david-b@pacbell.net>
References: <11871877051923-git-send-email-tony@atomide.com>
	<11871877263342-git-send-email-tony@atomide.com>
	<11871877282691-git-send-email-tony@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <11871877282691-git-send-email-tony@atomide.com>
Content-Disposition: inline
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

On Wednesday 15 August 2007, Tony Lindgren wrote:
> Tabify and clean-up musbhdrc.h

All those patches look nice to me, FWIW.  :)

I'd suggest sticking "Copyright (C) 2006-2007 Nokia Corporation" on
the code too.  With the amount of work this driver needed, I think
more people than just Mentor and TI deserve credit for whipping it
into shape!



> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
> =A0drivers/usb/musb/musbhdrc.h | =A0347 ++++++++++++++++++++-----------=
-----------
> =A01 files changed, 165 insertions(+), 182 deletions(-)
>=20
> diff --git a/drivers/usb/musb/musbhdrc.h b/drivers/usb/musb/musbhdrc.h
> index 4a84c2a..ec2a1af 100644
> --- a/drivers/usb/musb/musbhdrc.h
> +++ b/drivers/usb/musb/musbhdrc.h
> @@ -1,4 +1,4 @@
> -/******************************************************************
> +/*
> =A0 * Copyright 2005 Mentor Graphics Corporation
> =A0 * Copyright (C) 2005-2006 by Texas Instruments
> =A0 *
