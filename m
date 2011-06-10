From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH 2/4] msm: iommu: move to drivers/iommu/
Date: Fri, 10 Jun 2011 19:24:05 +0300
Message-ID: <BANLkTi=owGc5JU1eF5wZmgiC0GbTCury8w@mail.gmail.com>
References: <1307522062-19273-1-git-send-email-ohad@wizery.com>
 <1307522062-19273-3-git-send-email-ohad@wizery.com> <8yamxhsklhd.fsf@huya.qualcomm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pci-owner@vger.kernel.org>
In-Reply-To: <8yamxhsklhd.fsf@huya.qualcomm.com>
Sender: linux-pci-owner@vger.kernel.org
To: David Brown <davidb@codeaurora.org>
Cc: stepanm@codeaurora.org, Joerg Roedel <Joerg.Roedel@amd.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, David Woodhouse <dwmw2@infradead.org>, iommu@lists.linux-foundation.org, linux-pci@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Thu, Jun 9, 2011 at 1:27 AM, David Brown <davidb@codeaurora.org> wro=
te:
> Moving the driver is good. =A0I'm wondering what we should do with
> iommu_dev.c, though. =A0Wouldn't it make sense to move this file as w=
ell?

Yeah, it does make sense. I'll move that one too, thanks.
