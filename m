From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH] omap3: Add basic support for 720MHz part
Date: Wed, 19 Jan 2011 11:06:54 +0200
Message-ID: <4D36A9AE.1010606@ti.com>
References: <1295336995-15831-1-git-send-email-premi@ti.com> <789E54BD-D2B6-4B98-B9B8-19688E415E39@dominion.thruhere.net> <4D35C47D.6000102@ti.com> <b8bd13a9f9b383c7db6af63e1aa984be@mail.gmail.com> <4F6B1267-93B8-4698-9880-376076825598@dominion.thruhere.net> <3b2df4e1c65667c6383d654cca4be8ac@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog101.obsmtp.com ([74.125.149.67]:52255 "EHLO
	na3sys009aog101.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753069Ab1ASJG6 (ORCPT
	<rfc822;linux-omap@vger.kernel.org>);
	Wed, 19 Jan 2011 04:06:58 -0500
Received: by mail-yw0-f53.google.com with SMTP id 6so174664ywa.12
        for <linux-omap@vger.kernel.org>; Wed, 19 Jan 2011 01:06:58 -0800 (PST)
In-Reply-To: <3b2df4e1c65667c6383d654cca4be8ac@mail.gmail.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Vishwanath Sripathy <vishwanath.bs@ti.com>
Cc: Koen Kooi <koen@dominion.thruhere.net>, Sanjeev Premi <premi@ti.com>, l-o List <linux-omap@vger.kernel.org>, Thara Gopinath <thara@ti.com>

Vishwanath Sripathy wrote, on 01/19/2011 10:56 AM:
> If you want a quick hack, you can modify the voltage for 700M marginally
> (like you have done above). But it needs to be done in multiple places.
> You need to modify IVA OPP6 entry in opp table and OPP6 voltage value in
> voltage.h as well besides above change. This should work.
we may want to be sure about keeping the additional voltages in 1 step 
increment (12.5mV - to ensure twl conversion routines sane)- i think we 
may be pretty much maxed out for the tps chip used, no?

-- 
Regards,
Nishanth Menon
