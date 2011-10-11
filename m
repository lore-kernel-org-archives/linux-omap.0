From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 08/16] OMAP2+: UART: Store certain reg values to port structure
Date: Tue, 11 Oct 2011 18:51:20 +0530
Message-ID: <CAAL8m4wHYULvpjgJpM0gvhV_rcmBAz_=P5tUU+-DZ0=6i+jYoA@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
 <1317380495-584-8-git-send-email-govindraj.raja@ti.com> <8739f0bdqh.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <8739f0bdqh.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 11, 2011 at 5:28 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> In preparation to runtime conversion add missing uart regs to
>> port structure which can be used in context restore.
>> Also ensuring all uart reg info's are part of port structure.
>>
>> Signed-off-by: Govindraj.R <govindraj.raja@ti.com>
>
> IMO, this should come later in the series to avoid adding bunch of code
> that gets moved in a subsequent patch.
>
> First, convert to runtime PM (current patch 9/16)
> Then, add a patch to move context save/restore into driver.
> Then, add this patch.

Okay fine.

--
Thanks,
Govindraj.R
