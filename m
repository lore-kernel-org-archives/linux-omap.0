From: Govindraj <govindraj.ti@gmail.com>
Subject: Re: [PATCH v6 07/16] OMAP2+: UART: Add default mux for all uarts.
Date: Thu, 6 Oct 2011 13:51:27 +0530
Message-ID: <CAAL8m4zuZ5qFJBdKqNxbw4ApKQ6WnTXiy4yFgOFeeG4H2mtCrg@mail.gmail.com>
References: <1317380495-584-1-git-send-email-govindraj.raja@ti.com>
 <1317380495-584-7-git-send-email-govindraj.raja@ti.com> <87zkhf9s4p.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-serial-owner@vger.kernel.org>
In-Reply-To: <87zkhf9s4p.fsf@ti.com>
Sender: linux-serial-owner@vger.kernel.org
To: Kevin Hilman <khilman@ti.com>
Cc: "Govindraj.R" <govindraj.raja@ti.com>, linux-omap@vger.kernel.org, linux-serial@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Tony Lindgren <tony@atomide.com>, Partha Basak <p-basak2@ti.com>, Vishwanath Sripathy <vishwanath.bs@ti.com>, Rajendra Nayak <rnayak@ti.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>
List-Id: linux-omap@vger.kernel.org

Thanks for the review.

On Thu, Oct 6, 2011 at 12:34 AM, Kevin Hilman <khilman@ti.com> wrote:
> "Govindraj.R" <govindraj.raja@ti.com> writes:
>
>> Prior to this change rx-pad wakeup was done by writing to rx-pad off=
set value
>> populated in serial.c idle_init. Now with mux framework support we c=
an use
>> mux_utilities along with hmwod framework to handle io-pad configurat=
ion and
>> enable rx-pad wake-up mechanism.
>
> This patch (along with a few others) have compile errors when CONFIG_=
PM
> is not set.
>

Will check and fix this.

Please let me know on further comments on the series.

Will re-post fixing the same.

--
Thanks,
Govindraj.R


> Kevin
> --
> To unsubscribe from this list: send the line "unsubscribe linux-seria=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
--
To unsubscribe from this list: send the line "unsubscribe linux-serial"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
