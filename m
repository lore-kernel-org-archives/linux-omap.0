From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: Re: [RFC 2/6] omap: iovmm: generic iommu api migration
Date: Thu, 9 Jun 2011 09:42:22 +0300
Message-ID: <BANLkTikowqhMj=stjziwHeN4UxEKo09qrw@mail.gmail.com>
References: <1307053663-24572-1-git-send-email-ohad@wizery.com>
 <201106071326.53106.laurent.pinchart@ideasonboard.com> <BANLkTimqt=yMGHcqEH5u-4GkMX9=+BuB6A@mail.gmail.com>
 <201106081246.53106.laurent.pinchart@ideasonboard.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-media-owner@vger.kernel.org>
In-Reply-To: <201106081246.53106.laurent.pinchart@ideasonboard.com>
Sender: linux-media-owner@vger.kernel.org
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-media@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Hiroshi.DOYU@nokia.com, arnd@arndb.de, davidb@codeaurora.org, Joerg.Roedel@amd.com
List-Id: linux-omap@vger.kernel.org

On Wed, Jun 8, 2011 at 1:46 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Tuesday 07 June 2011 15:46:26 Ohad Ben-Cohen wrote:
>> Where do you take care of those potential offsets today ? Or do you
>> simply ignore the offsets and map the entire page ?
>
> Here http://marc.info/?l=linux-omap&m=130693502326513&w=2 :-)

:)

Ok so it seems iovmm will take care of that for now ?

Let's get the basics working with the IOMMU API and then revise this
when we switch from iovmm to the generic dma.

Thanks,
Ohad.
