From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [PATCH] iommu/omap: Fix build error with !IOMMU_SUPPORT
Date: Fri, 16 Sep 2011 12:57:08 +0300
Message-ID: <CAK=WgbbqJKdm+=s-+Zmv9b7aoWeB2-14W70RXhVCQGJPaUzJKw@mail.gmail.com>
References: <1316009259-18052-1-git-send-email-joerg.roedel@amd.com>
 <CAK=WgbbCgXjOQ=xXSwnVhT9sqsYtpo6cFcRQYSEGY2ow215n=Q@mail.gmail.com> <20110915104524.GY11701@amd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20110915104524.GY11701@amd.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Roedel, Joerg" <Joerg.Roedel@amd.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-omap@vger.kernel.org

On Thu, Sep 15, 2011 at 1:45 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> This doesn't work on platforms that may have more than one possible
> iommu driver, like x86 for example.

Ok.

Acked-by: Ohad Ben-Cohen <ohad@wizery.com>

(cc'ing Laurent for the VIDEO_OMAP3 part)
