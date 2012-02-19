From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 2/2] ARM: OMAP2: remove some orphan function declarations.
Date: Sun, 19 Feb 2012 20:09:00 +0400
Message-ID: <4F411E9C.7080108@ru.mvista.com>
References: <20120219022841.8254.86264.stgit@notabene.brown> <20120219022931.8254.29652.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120219022931.8254.29652.stgit@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Paul Walmsley <paul@pwsan.com>, "Govindraj . R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 19-02-2012 6:29, NeilBrown wrote:

> commit 2fd149645eb

    Please also specify that commit's summary in parens.

> removed omap_uart_can_sleep and omap3_can_sleep,
> but not their declarations.  So remove those now.

> Signed-off-by: NeilBrown <neilb@suse.de>

WBR, Sergei
