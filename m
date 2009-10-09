From: Nishanth Menon <nm@ti.com>
Subject: Re: Question on OPP table handling
Date: Thu, 8 Oct 2009 19:41:32 -0500
Message-ID: <4ACE86BC.70009@ti.com>
References: <1254420194-4757-1-git-send-email-premi@ti.com>	<4AC76810.1040206@gmail.com>	<B85A65D85D7EB246BE421B3FB0FBB59301DDC08B10@dbde02.ent.ti.com> <87ws39zsn4.fsf@deeprootsystems.com> <4ACA2A86.7060300@ti.com> <74583B8642AB8841B30447520659FCA9DDAEF27A@dnce01.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301DDC09146@dbde02.ent.ti.com> <4ACB2DAD.1090200@ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301DDC0936B@dbde02.ent.ti.com> <4ACB3243.409@ti.com> <74583B8642AB8841B30447520659FCA9DDAEF4D6@dnce01.ent.ti.com> <B85A65D85D7EB246BE421B3FB0FBB59301DDC09388@dbde02.ent.ti.com> <74583B8642AB8841B30447520659FCA9DDAEF565@dnce01.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from arroyo.ext.ti.com ([192.94.94.40]:36909 "EHLO arroyo.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756855AbZJIAmK (ORCPT <rfc822;linux-omap@vger.kernel.org>);
	Thu, 8 Oct 2009 20:42:10 -0400
In-Reply-To: <74583B8642AB8841B30447520659FCA9DDAEF565@dnce01.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Cousson, Benoit" <b-cousson@ti.com>
Cc: "Dasgupta, Romit" <romit@ti.com>, "Premi, Sanjeev" <premi@ti.com>, Kevin H <khilman@deeprootsystems.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>

Sanjeev, All,
Cousson, Benoit had written, on 10/06/2009 07:52 AM, the following:
> Yes, it is true but you might have to disable dynamically some OPP (l=
ike OPP5 and OPP4) for thermal management reason. The way the resource =
is handled today, you cannot force the reduction of the frequency in ca=
se of thermal issue.
> I agree that there might be more elegant way to deal with that, but w=
e can take advantage of disabling dynamically any OPP to do it.
I would like to introduce OPP tables for 3630, but I will be dependent=20
on  http://marc.info/?l=3Dlinux-omap&m=3D125442020209267&w=3D2

Let me know how I can introduce the following into l-o + l-o pm. ( I=20
suppose l-o first=85):
http://dev.omapzoom.org/?p=3Dintegration/kernel-omap3.git;a=3Dblob;f=3D=
arch/arm/mach-omap2/omap3-opp.h;h=3Dac3ae6f219b37760de00e8e469ae3911d02=
f0304;hb=3Drefs/heads/sync_wake-up3630#l74

Not sure of the status and plan on this. Could we sync on this?

--=20
Regards,
Nishanth Menon
--
To unsubscribe from this list: send the line "unsubscribe linux-omap" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
