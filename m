From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: Re: mfd: twl-core: Return directly after a failed
 platform_device_alloc() in add_numbered_child()
Date: Tue, 17 May 2016 16:15:32 +0200
Message-ID: <1af9287a-2899-fe47-6e47-59ee7cc8f883@users.sourceforge.net>
References: <566ABCD9.1060404@users.sourceforge.net>
 <5682D228.7070902@users.sourceforge.net> <20160111082922.GB14104@x1>
 <05b7db2a-437a-60ac-d289-71d2150e7f5f@users.sourceforge.net>
 <3c168185-ec2d-f1f7-fe70-8a230b884ed2@users.sourceforge.net>
 <alpine.DEB.2.02.1605160845050.2060@localhost6.localdomain6>
 <9f94708f-6433-5227-78ee-52fbfb30fdaf@users.sourceforge.net>
 <alpine.DEB.2.02.1605161006350.2060@localhost6.localdomain6>
 <20160517060059.GB17238@dell>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160517060059.GB17238@dell>
Sender: linux-kernel-owner@vger.kernel.org
To: Lee Jones <lee.jones@linaro.org>
Cc: Julia Lawall <julia.lawall@lip6.fr>, Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

> Please remove the print altogether.

Would you like to omit any extra logging statements at more source code places?

Regards,
Markus
