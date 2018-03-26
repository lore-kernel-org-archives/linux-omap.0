From: "=?utf-8?B?6ZmI5Y2O5omN?=" <chenhc@lemote.com>
Subject: Re: Regression with arm in next with stack protector
Date: Mon, 26 Mar 2018 14:57:17 +0800
Message-ID: <tencent_79FD53B203715FD7439C6EAB@qq.com>
References: <20180323181452.GJ5799@atomide.com>
 <CAOMZO5Bmpk4cwav-qTnNA6L16DwdDPp5LeKC-jY9=QzfVBuKSQ@mail.gmail.com>
 <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180323121530.f28dc29939d9395268911a4e@linux-foundation.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: =?utf-8?B?QW5kcmV3IE1vcnRvbg==?= <akpm@linux-foundation.org>, =?utf-8?B?RmFiaW8gRXN0ZXZhbQ==?= <festevam@gmail.com>
Cc: =?utf-8?B?U3RlcGhlbiBSb3Rod2VsbA==?= <sfr@canb.auug.org.au>, =?utf-8?B?UmljaCBGZWxrZXI=?= <dalias@libc.org>, =?utf-8?B?UnVzc2VsbCBLaW5n?= <linux@arm.linux.org.uk>, =?utf-8?B?WW9zaGlub3JpIFNhdG8=?= <ysato@users.sourceforge.jp>, =?utf-8?B?VG9ueSBMaW5kZ3Jlbg==?= <tony@atomide.com>, =?utf-8?B?bGludXgta2VybmVs?= <linux-kernel@vger.kernel.org>, =?utf-8?B?UmFsZiBCYWVjaGxl?= <ralf@linux-mips.org>, =?utf-8?B?bGludXgtb21hcA==?= <linux-omap@vger.kernel.org>, =?utf-8?B?SmFtZXMgSG9nYW4=?= <james.hogan@mips.com>, =?utf-8?B?bW9kZXJhdGVkIGxpc3Q6QVJNL0ZSRUVTQ0FMRSBJTVggLyBNWEMgQVJNIEFSQ0hJVEVDVFVSRQ==?= <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi, Tony and Fabio,

Could you please upload your kernel binary to somewhere for me? I don't understand why some ARM boards is OK while others are broken.

Huacai
 
------------------ Original ------------------
From:  "Andrew Morton"<akpm@linux-foundation.org>;
Date:  Sat, Mar 24, 2018 03:15 AM
To:  "Fabio Estevam"<festevam@gmail.com>;
Cc:  "Tony Lindgren"<tony@atomide.com>; "Huacai Chen"<chenhc@lemote.com>; "Stephen Rothwell"<sfr@canb.auug.org.au>; "Rich Felker"<dalias@libc.org>; "Russell King"<linux@arm.linux.org.uk>; "Yoshinori Sato"<ysato@users.sourceforge.jp>; "linux-kernel"<linux-kernel@vger.kernel.org>; "Ralf Baechle"<ralf@linux-mips.org>; "linux-omap"<linux-omap@vger.kernel.org>; "James Hogan"<james.hogan@mips.com>; "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE"<linux-arm-kernel@lists.infradead.org>;
Subject:  Re: Regression with arm in next with stack protector
 
On Fri, 23 Mar 2018 15:45:27 -0300 Fabio Estevam <festevam@gmail.com> wrote:

> On Fri, Mar 23, 2018 at 3:14 PM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi,
> >
> > Looks like commit 5638790dadae ("zboot: fix stack protector in
> > compressed boot phase") breaks booting on arm.
> 
> Yes, almost all imx are broken in linux-next due to this commit:
> https://kernelci.org/soc/imx/job/next/kernel/next-20180323/

Thanks, I dropped it and I expect Stephen will also do that.
