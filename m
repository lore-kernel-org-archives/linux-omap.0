From: toshihiro.kobayashi@nokia.com
Subject: Re: Which patches for 2.6.15 for 5912OSK?
Date: Tue, 14 Mar 2006 01:12:03 +0900 (JST)
Message-ID: <20060314.011203.846939260.toshihiro.kobayashi@nokia.com>
References: <001101c644ea$26a680c0$0301a8c0@hydra>
	<003601c6468b$2d1dbd40$642aa8c0@BUFFY>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <003601c6468b$2d1dbd40$642aa8c0@BUFFY>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: richard.copeman@lauterbach.co.uk
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Hi,

From: "Richard Copeman" <richard.copeman@lauterbach.co.uk>
Subject: RE: Which patches for 2.6.15 for 5912OSK?
Date: Mon, 13 Mar 2006 10:44:59 -0000

> Hi Michal,
> 
> Thanks for the information. I only had to copy two files from plat-omap to
> mach-omap1: pm.c and sleep.S
> 
> I have a running kernel. Now I just need to configure the dsp gateway. Do
> you have any information on how to do that?

I don't think I had any issues with linux-2.6.15 + patch-2.6.15-omap2.

You should see the DSP Gateway configuration at
  System Type
    ---> TI OMAP Implementations
      ---> OMAP DSP Driver (DSP Gateway)

BR,
Toshihiro Kobayashi
