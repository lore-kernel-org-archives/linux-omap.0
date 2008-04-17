From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: OMAP3 DSPBridge review
Date: Thu, 17 Apr 2008 11:54:59 +0530
Message-ID: <5d5443650804162324n2a11c2f2na4c81176aadf143a@mail.gmail.com>
References: <5d5443650804160742y71ae769dub7716e75b77a40e5@mail.gmail.com>
	 <EBA93F3E4CB46947A4C5275F6308CF3E026F87F9@dlee15.ent.ti.com>
	 <5d5443650804162254i4cfd5604ve9cbf5afc8acbe37@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.184]:3803 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751419AbYDQGZE (ORCPT
	<rfc822;linux-omap@vger.kernel.org>); Thu, 17 Apr 2008 02:25:04 -0400
Received: by fk-out-0910.google.com with SMTP id 19so3189270fkr.5
        for <linux-omap@vger.kernel.org>; Wed, 16 Apr 2008 23:25:02 -0700 (PDT)
In-Reply-To: <5d5443650804162254i4cfd5604ve9cbf5afc8acbe37@mail.gmail.com>
Content-Disposition: inline
Sender: linux-omap-owner@vger.kernel.org
List-Id: linux-omap@vger.kernel.org
To: "Pasam, Vijay" <vpasam@ti.com>
Cc: "Kanigeri, Hari" <h-kanigeri2@ti.com>, linux-omap@vger.kernel.org

Hi Vijay,

On Thu, Apr 17, 2008 at 11:24 AM, Trilok Soni <soni.trilok@gmail.com> wrote:
> Hi Vijay,
>
>
>
>  On Thu, Apr 17, 2008 at 8:15 AM, Pasam, Vijay <vpasam@ti.com> wrote:
>  > Hi Trilok:
>  >
>  >
>  >
>  >  >
>  >  > I was just going this dspbridge code, and I was surprised to
>  >  > find layers for un-necessary things, where we could have
>  >  > simply called the linux kernel provided function. Here goes the list:
>  >  >
>  >  > 1. There is un-necessary "linux" directory inside mpu_driver
>  >  > source codes. e.g src/osal/linux etc. I hope we are writing
>  >  > this code for Linux kernel only.
>  >  > 2. src/osal/linux
>  >  >   - As the name suggest for directory it is OS Abstraction
>  >  > layer for Linux. I don't see any need for this at all. In
>  >  > Linux kernel, we follow approach of directly calling the
>  >  > provided functions and not to further wrap it until necessary.
>  >  >
>  >  > src/osal/list.c
>  >  >
>  >  > - This whole file tries implement doubly linked list code, I
>  >  > am sure you can get away this with list.h itself. I don't see
>  >  > any need of further wrapping it.
>  >  >
>  >  > src/osal/kfile.c
>  >  >
>  >  > - Don't use KENREL_VERSION comparision check unless very much
>  >  > necessary, always try to keep driver in sync in latest kernel
>  >  > version instead.
>  >  > - Again there are wrappers for file reading functions
>  >  > provided by kernel.
>  >  > - If this functions are only used for doff loader, then
>  >  > moving it to outside kernel space, then we can get away with
>  >  > this functions.
>  >  >
>  >  > src/osal/mem.c
>  >  >
>  >  > - I see here that you guys are maintaining the pool of memory
>  >  > allocated with dma_alloc_coherent, you guys should have used
>  >  > existing mempool apis instead, look at dspgw code for example.
>  >  >
>  >  > src/osal/isr.c
>  >  >
>  >  > - Not required, please call request_irq/free_irq directly
>  >  > please. I also see lots of #ifdef LINUX and #ifndef LINUX,
>  >  > does TI also target to build this code for WinCE and Symbian
>  >  > like OS. If yes, I don't see how we are going to maintain
>  >  > this along with community.
>  >  >
>  >  > src/osal/dpc.c - please call tasklet functions directly instead.
>  >  >
>  >  > src/pmgr/linux/common/dmm.c -
>  >
>  >  One of the goals of bridge is easier portability to other RTOS. You are
>  >  right about the additional layer to call into Linux OS. This was
>  >  intended to port this to other OS'es easily.
>  >
>
>  TI has to decide, what path they have to follow now onwards for
>  bridge, I see no need of OSAL layer, when we are targeting this as
>  Linux kernel driver.
>
>  It would be tough to get contributions as this code at first sight
>  looks harder to understand. Let's have some ideas on how we can clean
>  this code gradually without breaking API compatibility and IPC layer.
>  Common MMU and Mailbox framework written in Nokia dspgw should also be
>  utilized in this.
>

Forgot to mention that "documents" folder contains documents in MS$
.doc format. Please publish them in .pdf instead. Later the steps can
be converted to dspbridge-wiki pages.


-- 
---Trilok Soni
http://triloksoni.wordpress.com
