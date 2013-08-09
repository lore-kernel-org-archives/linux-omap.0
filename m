From: Vikram Narayanan <vikram186@gmail.com>
Subject: Ti-st suspend/resume hooks
Date: Fri, 09 Aug 2013 15:14:11 +0530
Message-ID: <5204B9EB.4020809@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Sender: linux-pm-owner@vger.kernel.org
To: linux-omap@vger.kernel.org, Pavan Savoy <pavan_savoy@ti.com>
Cc: LAK <linux-arm-kernel@lists.infradead.org>, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

Our i.Mx6 based platform has a wl12xx chip and the ti-st driver is in 
use. When the system goes to suspend, the st_kim module fails to suspend 
giving out -EOPNOTSUPP [1], which is quite evident from the the missing 
suspend/resume hooks in the wilink_platform_data. [2]

Are there any ways to make this ti-st driver suspend/resume aware?

Thanks,
Vikram

[1] http://lxr.linux.no/linux+v3.10.5/drivers/misc/ti-st/st_kim.c#L833

[2] 
http://lxr.linux.no/linux+v3.10.5/arch/arm/mach-omap2/board-omap4panda.c#L58

P.S: I'm not subscribed to the list. Please keep me Cc'd.
