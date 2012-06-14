From: "R, Sricharan" <r.sricharan@ti.com>
Subject: Re: [PATCH 2/4] ARM: OMAP2+: Move the stubbed prm and cm functions to
 prcm.c file and make them __weak.
Date: Thu, 14 Jun 2012 17:26:21 +0530
Message-ID: <CAJ7qFSdiMgM3S5Q+XaFAGrgcL5M5f8CLHyKSRtBKu4AK6ei-BA@mail.gmail.com>
References: <1336669615-16454-1-git-send-email-r.sricharan@ti.com>
 <1336669615-16454-3-git-send-email-r.sricharan@ti.com>
 <alpine.DEB.2.00.1205101140230.32719@utopia.booyaka.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <alpine.DEB.2.00.1205101140230.32719@utopia.booyaka.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Paul Walmsley <paul@pwsan.com>
Cc: b-cousson@ti.com, tony@atomide.com, paul@pswan.com, santosh.shilimkar@ti.com, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hi Paul,

>> Some prm and cm registers read/write and status functions
>> are built only for some custom OMAP2+ builds and are stubbed
>> in header files for other builds under ifdef statements.
>> But this results in adding new CONFIG_ARCH_OMAPXXX
>> checks when SOCs are added in the future. So move them
>> to a common place for OMAP2+ and make them 'weak' implementations.
>
> Thanks for the patch. =A0These stubs aren't needed any longer, so we can
> just get rid of them; no need to mark them __weak. =A0I've got a patch to
> just drop them here to be posted soon as part of a larger PRCM cleanup.
>
>
  Is the PRCM cleanup series available now ?

Thanks,
 Sricharan
