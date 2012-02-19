From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH 1/2] ARM: OMAP2+: UART: remove unused fields in omap_uart_state.
Date: Sun, 19 Feb 2012 20:10:46 +0400
Message-ID: <4F411F06.20006@ru.mvista.com>
References: <20120219022841.8254.86264.stgit@notabene.brown> <20120219022931.8254.38314.stgit@notabene.brown>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <20120219022931.8254.38314.stgit@notabene.brown>
Sender: linux-serial-owner@vger.kernel.org
To: NeilBrown <neilb@suse.de>
Cc: Alan Cox <alan@linux.intel.com>, Paul Walmsley <paul@pwsan.com>, "Govindraj . R" <govindraj.raja@ti.com>, linux-serial@vger.kernel.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

Hello.

On 19-02-2012 6:29, NeilBrown wrote:

> commit 2fd149645eb46d261 removed the last usage of 'can_sleep' but
> did not remove the field.
> commit  8612bd22f3036974 removed the last non-trivial use of 'pdev'.

    Please also specify the summaries of the above commits with them.

> So remove these fields and the one trivial use.

    This seems like the material for 2 patches.

> Acked-by: Govindraj.R <govindraj.raja@ti.com>
> Signed-off-by: NeilBrown <neilb@suse.de>

WBR, Sergei
