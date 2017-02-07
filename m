From: Arvind Yadav <arvind.yadav.cs@gmail.com>
Subject: Re: [PATCH] omapfb: dss: Handle return error in dss_init_ports.
Date: Tue, 7 Feb 2017 17:41:37 +0530
Message-ID: <c0063f69-e6f8-ce91-8069-308fe4ddb86a@gmail.com>
References: <CGME20170203122444epcas2p3e0d5ed32cac85fd86d900a62dbeb03a4@epcas2p3.samsung.com>
 <1486124625-23454-1-git-send-email-arvind.yadav.cs@gmail.com>
 <15170308.DWakhCLKvX@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <15170308.DWakhCLKvX@amdc3058>
Sender: linux-kernel-owner@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Cc: tomi.valkeinen@ti.com, linux-omap@vger.kernel.org, linux-fbdev@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi,

In dss_init_ports, There is no need to add dss_uninit_ports before 
returning.
Because it's already take care in dss_bind. dss_bind  is handling
dss_uninit_ports in error path.

-Arvind


On Monday 06 February 2017 08:58 PM, Bartlomiej Zolnierkiewicz wrote:
> dpi_uninit_port() & sdi_uninit_port() skip not fully
> initialized port
