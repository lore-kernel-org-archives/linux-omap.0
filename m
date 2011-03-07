From: Nishanth Menon <nm@ti.com>
Subject: Re: [PATCH V3 03/19] OMAP3+: voltage: remove initial voltage
Date: Mon, 07 Mar 2011 08:22:32 +0530
Message-ID: <4D744870.20909@ti.com>
References: <1299338962-5602-1-git-send-email-nm@ti.com> <1299338962-5602-4-git-send-email-nm@ti.com> <4D738E04.5090207@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from na3sys009aog113.obsmtp.com ([74.125.149.209]:33575 "EHLO
	na3sys009aog113.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754883Ab1CGCwk (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Sun, 6 Mar 2011 21:52:40 -0500
Received: by yxh35 with SMTP id 35so1593432yxh.8
        for <linux-omap@vger.kernel.org>; Sun, 06 Mar 2011 18:52:39 -0800 (PST)
In-Reply-To: <4D738E04.5090207@ru.mvista.com>
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@mvista.com>
Cc: linux-omap <linux-omap@vger.kernel.org>, Kevin Hilman <khilman@ti.com>, Tony <tony@atomide.com>, Paul <paul@pwsan.com>, linux-arm <linux-arm-kernel@lists.infradead.org>

Sergei Shtylyov wrote, on 03/06/2011 07:07 PM:
>
>> Blindly setting a 1.2V setting
>
>     Hm, seems tautological...
As a non native English speaker, I would like to understand how we could 
improve this. I suppose you mean "Blindly setting 1.2V" is better here. 
Am i correct?

>> in the initial structure may not even
>> match the default voltages stored in the voltage table which are
>> supported for the domain. For example, OMAP3430 core domain does not
>> use 1.2V and ends up generating a warning on the first transition.
[..]

-- 
Regards,
Nishanth Menon
