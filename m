From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v7 17/21] OMAP2+: UART: Remove omap_uart_can_sleep and add pm_qos
Date: Fri, 11 Nov 2011 15:47:58 +0530
Message-ID: <CAAL8m4x82jAsVLknLisjML3HegrJnRF07MpojEyAQeS1dg4nKg@mail.gmail.com>
References: <1318952110-10659-1-git-send-email-govindraj.raja@ti.com>
 <1318952110-10659-3-git-send-email-govindraj.raja@ti.com> <87vcqz33y8.fsf@ti.com>
 <4EB8F368.5070603@ti.com> <87r51i1kva.fsf@ti.com> <CAAL8m4zLEnQE+BkK4xmLUBkREYOuqjmbBweKS0_qcEYUMo71nQ@mail.gmail.com>
 <87aa83er84.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87aa83er84.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: Rajendra Nayak <rnayak@ti.com>, "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, linux-serial@vger.kernel.org, Vishwanath Sripathy <vishwanath.bs@ti.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Fri, Nov 11, 2011 at 12:32 AM, Kevin Hilman <khilman@ti.com> wrote:
> Govindraj <govindraj.ti@gmail.com> writes:
>

[..]

>>
>> I have fixed this and other uart_v7 comments and have re-based the
>> patch series on top
>> of 3.2-rc1 along with Tero's v9 irq chaining patches and tested the same.
>> Available here [1].
>
> Please repost your updated series.

Yes done. v8 posted [1]

>
>> Can this patches series be added to a test branch for upstreaming or do you
>> think there are still some outstanding comments that needs to be discussed?
>
> The PRCM IRQ chaining series is not yet finalized.

okay fine.

--
Thanks,
Govindraj.R

[1]:
http://www.spinics.net/lists/linux-omap/msg60115.html
