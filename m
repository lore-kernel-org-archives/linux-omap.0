From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH v3 1/6] iommu/core: split mapping to page sizes as
	supported by the hardware
Date: Fri, 14 Oct 2011 19:05:44 +0200
Message-ID: <CAK=WgbaG5YNxESEhcW3Usgvx_9QLXT3OkNWXhgsaCDZ3yVZaVA@mail.gmail.com>
References: <20110927131222.GL2138@amd.com>
	<CAK=WgbYG2tpMJ2SikZhm=R9j5kQ6Hm8CGg=q1bko3idzF53Q3Q@mail.gmail.com>
	<20110927181438.GM2138@amd.com>
	<CAK=WgbbNs5fWHDEputZ=jzU5YN0sn0tf6AETkcsoq_Jbvc2XgQ@mail.gmail.com>
	<20111010094738.GW2138@amd.com>
	<CAK=WgbZ7Wyax1yfS1jSXw9OdwMtxxidwLO8PTsNUXX9CWzmVrw@mail.gmail.com>
	<20111010153609.GB2138@amd.com>
	<CAK=WgbbnuO67X46sqS87q2vw2TWq3Ekvw5p1PmXvXinQXMyowg@mail.gmail.com>
	<20111011103820.GF2138@amd.com>
	<CAK=WgbYOUZNX0OmRwZNO1mMG+3DZXwff+S60ESWixf04HOcbtw@mail.gmail.com>
	<20111014133510.GC2198@amd.com>
	<CAK=Wgbar+z_Nm1cDM4bJgrP5yWbjCsVBW=orfYwsZsT7uET8ng@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAK=Wgbar+z_Nm1cDM4bJgrP5yWbjCsVBW=orfYwsZsT7uET8ng@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, Hiroshi Doyu <hdoyu@nvidia.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, David Brown <davidb@codeaurora.org>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, David Woodhouse <dwmw2@infradead.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Stepan Moskovchenko <stepanm@codeaurora.org>
List-Id: linux-omap@vger.kernel.org

On Fri, Oct 14, 2011 at 7:03 PM, Ohad Ben-Cohen <ohad@wizery.com> wrote:
>> Btw, how have you tested this code?
>
> Of course. Every patch I send is always tested on...

*oops I thought you asked "Btw, have you tested this code?". I missed
the "how" part :)
