From: "Shilimkar, Santosh" <santosh.shilimkar@ti.com>
Subject: RE: [PATCH 00/14] omap sram, omap4 control module and es2.0 support
Date: Fri, 17 Sep 2010 20:40:22 +0530
Message-ID: <EAF47CD23C76F840A9E7FCE10091EFAB02CD307E7B@dbde02.ent.ti.com>
References: <1284716878-27667-1-git-send-email-santosh.shilimkar@ti.com>
	<AANLkTi=z+FE14Uacfhuuk_U_g-9taMsN9tL4VW-j5qt0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <AANLkTi=z+FE14Uacfhuuk_U_g-9taMsN9tL4VW-j5qt0@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Bryan Wu <bryan.wu@canonical.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

> -----Original Message-----
> From: cooloney@gmail.com [mailto:cooloney@gmail.com] On Behalf Of Bryan Wu
> Sent: Friday, September 17, 2010 8:36 PM
> To: Shilimkar, Santosh
> Cc: linux-omap@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: Re: [PATCH 00/14] omap sram, omap4 control module and es2.0
> support
> 
> Santosh,
> 
> Unfortunately, the kernel still cannot find MMC device and mount the
> root file system on my Panda ES2.0 8 layers board.
> Did we miss some patches? The Ubuntu 2.6.35 kernel boots fine.
> 
Use the patch posted by Madhu for MMC apart from this series
http://www.mail-archive.com/linux-omap@vger.kernel.org/msg34855.html

I didn't find any issues with my es2.0 Panda board.
Kevin also tested his Panda where MMC worked well.

Not sure what is the problem with your board,

Regards,
Santosh
