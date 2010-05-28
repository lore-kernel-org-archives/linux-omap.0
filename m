From: Ming Lei <tom.leiming@gmail.com>
Subject: Re: [PATCH] ARM: OMAP: Fix board data to support device only, host
	only and OTG roles.
Date: Fri, 28 May 2010 23:48:51 +0800
Message-ID: <AANLkTinIC2D8kQKSUdxMZVVSlIxYzVw1txqJrIN2DPne@mail.gmail.com>
References: <20100521065218.GG925@nokia.com>
	<420791.3389.qm@web180306.mail.gq1.yahoo.com>
	<5A47E75E594F054BAF48C5E4FC4B92AB032194B74C@dbde02.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from mail-pz0-f186.google.com ([209.85.222.186]:55227 "EHLO
	mail-pz0-f186.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758490Ab0E1Psw (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Fri, 28 May 2010 11:48:52 -0400
In-Reply-To: <5A47E75E594F054BAF48C5E4FC4B92AB032194B74C@dbde02.ent.ti.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Gadiyar, Anand" <gadiyar@ti.com>
Cc: David Brownell <david-b@pacbell.net>, "Gupta, Ajay Kumar" <ajay.gupta@ti.com>, "felipe.balbi@nokia.com" <felipe.balbi@nokia.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "Mankad, Maulik Ojas" <x0082077@ti.com>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, Tony Lindgren <tony@atomide.com>

2010/5/28 Gadiyar, Anand <gadiyar@ti.com>:
> David Brownell wrote:
>
> (Okay, I do know anyone who compiles a custom kernel of
> this sort is likely capable of patching the board files
> as needed to downgrade to the desired mode. But I still
> think the patch at [1] is useful to have.)

David NAK the patch and it is the reason:

1, don't support mini-A plug connected into mini-ab receptacle if
degrading to host-only role;

and

2,don't support mini-B plug connected into mini-ab receptacle if
degrading to peripheral-only role.

This two cases may confuse users.

Maybe we can print messages to user to show the cases above.
Anyway, I don't mind if the patch is accepted or not.


-- 
Lei Ming
