From: Adam Ford <aford173@gmail.com>
Subject: Re: [RFC v2 1/2] ARM: dts: omap3: Add cpu trips and cooling map for
 omap3 family
Date: Wed, 30 Oct 2019 07:00:40 -0500
Message-ID: <CAHCN7xL5sqLzaJ9b0721iAUeEb_pKB4QaeXfF94TZLQ7ZaS+bg@mail.gmail.com>
References: <20190913153714.30980-1-aford173@gmail.com> <B710D701-6311-4344-BF4E-F39157BBF2BD@goldelico.com>
 <CAHCN7xKU1v-BFkwiuZQx82+Cmdgj_1CH1j51bN0TaaduWcu8rQ@mail.gmail.com>
 <97204F98-FA33-4EBA-80AC-2FB3A6E78B2B@goldelico.com> <CAHCN7xJus=Unsm5rvgtccM9jpdiwGnJXrfjhavwkoswGbNd7qw@mail.gmail.com>
 <CAHCN7x+=O6f4Q0ps1d5KA+-E9L-8wr5B9XggzurJWtEnxEj7yg@mail.gmail.com>
 <FD6FED45-EF20-49D8-A2B2-012FB314DCC6@goldelico.com> <CAHCN7xLN+52ZW6tzCQPDvwqrdgaQaMrkhPFPotYDr7RdNwqeNA@mail.gmail.com>
 <C469028D-959D-4BD1-9226-C0190A197CE5@goldelico.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <C469028D-959D-4BD1-9226-C0190A197CE5@goldelico.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "H. Nikolaus Schaller" <hns@goldelico.com>
Cc: Linux-OMAP <linux-omap@vger.kernel.org>, Adam Ford <adam.ford@logicpd.com>, Nishanth Menon <nm@ti.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?= <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, devicetree <devicetree@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Grazvydas Ignotas <notasas@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Oct 30, 2019 at 3:40 AM H. Nikolaus Schaller <hns@goldelico.com> wrote:
>
> Hi Adam,
> what is the status of this RFC/PATCH?

I've submitted a formal 2-part patch [1] and [2], but Tony is
concerned about power consumption.  As of right now, I don't have
cycles to work on it.  My employer is about to release two new SOM's,
and I'm writing up some documentation on some of the older ones to
help some of the developers working on the new ones make their job go
quicker.

[1] - https://patchwork.kernel.org/patch/11178561/
[2] - https://patchwork.kernel.org/patch/11178563/

I requested if we could apply them as-is with 'status=disabled' for
now until the bus is fixed, but I think there was some push-back.

I'm trying to get to it.  I am hoping to find a little time this weekend.

adam
>
> BR and thanks,
> Nikolaus
>
