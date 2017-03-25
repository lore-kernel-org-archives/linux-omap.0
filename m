From: Felipe Balbi <balbi@kernel.org>
Subject: Re: [PATCH 0/7] dwc3 - bug fixes and use meaningful goto labels
Date: Sat, 25 Mar 2017 09:51:28 +0200
Message-ID: <87poh523r3.fsf@linux.intel.com>
References: <cover.1490387086.git.shuahkh@osg.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cover.1490387086.git.shuahkh@osg.samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: gregkh@linuxfoundation.org, kgene@kernel.org, krzk@kernel.org, javier@osg.samsung.com
Cc: Shuah Khan <shuahkh@osg.samsung.com>, linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org


Hi,

Shuah Khan <shuahkh@osg.samsung.com> writes:
> This patch series consists of two fixes and changes to goto labels

we *NEVER* put cleanups and fixes together.

> to use meaningful names.
>
> While working on goto label changes, I noticed  put_sync calls without
> successful get_sync in error legs.  The first two patches are the fixes
> and the rest of the patches are goto label changes.

so, you mean to say that you're adding regressions because you *THOUGHT*
there was a bug there, right? Read the docs ;-)

-- 
balbi
