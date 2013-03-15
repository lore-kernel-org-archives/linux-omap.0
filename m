From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH] rtc: omap: update to devm_* API
Date: Fri, 15 Mar 2013 16:19:45 +0530
Message-ID: <5142FCC9.1030302@ti.com>
References: <1363157464-9962-1-git-send-email-manishv.b@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1363157464-9962-1-git-send-email-manishv.b@ti.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Vishwanathrao Badarkhe, Manish" <manishv.b@ti.com>
Cc: linux-kernel@vger.kernel.org, rtc-linux@googlegroups.com, linux-omap@vger.kernel.org, davinci-linux-open-source@linux.davincidsp.com, a.zummo@towertech.it
List-Id: linux-omap@vger.kernel.org

On 3/13/2013 12:21 PM, Vishwanathrao Badarkhe, Manish wrote:
> From: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com> 
> 
> Update the code to use devm_* API so that driver
> core will manage resources.
> 
> Signed-off-by: Vishwanathrao Badarkhe, Manish <manishv.b@ti.com>

Tested on DA850 EVM.

Tested-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
