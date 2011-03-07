From: "Ramirez Luna, Omar" <omar.ramirez@ti.com>
Subject: Re: [PATCH] OMAP2+: hwmod: use status bit info for reset line
Date: Mon, 7 Mar 2011 01:25:00 -0600
Message-ID: <AANLkTimA3ZUUh=yDJ3n=R+6vmx9Eboe-t_veN+EQrYTA@mail.gmail.com>
References: <1299026809-32168-1-git-send-email-omar.ramirez@ti.com>
	<alpine.DEB.2.00.1103041326200.10981@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog102.obsmtp.com ([74.125.149.69]:41238 "EHLO
	na3sys009aog102.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751289Ab1CGHZC convert rfc822-to-8bit
	(ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Mon, 7 Mar 2011 02:25:02 -0500
Received: by pve39 with SMTP id 39so966500pve.17
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 23:25:01 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1103041326200.10981@utopia.booyaka.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Paul Walmsley <paul@pwsan.com>
Cc: Benoit Cousson <b-cousson@ti.com>, Tony Lindgren <tony@atomide.com>, Russell King <linux@arm.linux.org.uk>, lo <linux-omap@vger.kernel.org>, lak <linux-arm-kernel@lists.infradead.org>

Hi Paul

On Fri, Mar 4, 2011 at 3:36 PM, Paul Walmsley <paul@pwsan.com> wrote:
> It's after our -rc6 cutoff, but I'll take it anyway for 2.6.39. =A0Ma=
de a
> few minor changes -- updated patch below -- if you have a chance, ple=
ase
> give it a quick test. =A0The 'integration-2.6.39' branch at
> git://git.pwsan.com/linux-integration now contains it. =A0Or if you h=
ave any
> comments about the changes, those are welcome too.

Agree with changes, didn't see any issue either while testing.

Regards,

Omar
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
