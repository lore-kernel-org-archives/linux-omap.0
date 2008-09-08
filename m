From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH]Add 3430 SDP board level support for HSMMC2
Date: Mon, 8 Sep 2008 12:26:17 -0700
Message-ID: <200809081226.18098.david-b@pacbell.net>
References: <33259.192.168.10.89.1218608332.squirrel@dbdmail.itg.ti.com> <20080813085433.D5C2F363253@adsl-69-226-248-13.dsl.pltn13.pacbell.net> <00cf01c8fd26$cfc751b0$LocalHost@wipultra1303>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from smtp117.sbc.mail.sp1.yahoo.com ([69.147.64.90]:36536 "HELO
	smtp117.sbc.mail.sp1.yahoo.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753109AbYIHT0U (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Mon, 8 Sep 2008 15:26:20 -0400
In-Reply-To: <00cf01c8fd26$cfc751b0$LocalHost@wipultra1303>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Madhusudhan Chikkature <madhu.cr@ti.com>
Cc: tony@atomide.com, linux-omap@vger.kernel.org

On Wednesday 13 August 2008, Madhusudhan Chikkature wrote:
> > A better way to do this would be to let the boards say exactly
> > what the hardware configuration is, rather than requiring all
> > OMAP3 boards to be set up exactly like the SDP...
>
> I think the initial version was written specific to SDP. Later
> on it was changed to hsmmc.c and the platforms which required
> simillar setup as SDP started using it.

Right ...


> Now, if support for a new board is required which is unlike SDP a  
> new file can still be added for that perticular board, right?

Each board already gets a board-XYZ.c file.  So the clean way
to do this is to have that file set up its hsmmc config ... NOT
to clone versions of hsmmc.c for each board!
