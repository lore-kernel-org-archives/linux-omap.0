From: Faiz Abbas <faiz_abbas@ti.com>
Subject: Re: [PATCH v7 7/8] dt-bindings: can: m_can: Document new can
 transceiver binding
Date: Fri, 12 Jan 2018 11:54:49 +0530
Message-ID: <1e4ef9d8-4d81-e3d8-4a1e-e497877bbd1b@ti.com>
References: <1515581725-29242-1-git-send-email-faiz_abbas@ti.com>
 <1515581725-29242-8-git-send-email-faiz_abbas@ti.com>
 <CAL_JsqJs2Xi=LX3A=AYzBiOy3OPZCP0KRi=uHwiMK45fAGtODQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAL_JsqJs2Xi=LX3A=AYzBiOy3OPZCP0KRi=uHwiMK45fAGtODQ@mail.gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Rob Herring <robh+dt@kernel.org>
Cc: Wolfgang Grandegger <wg@grandegger.com>, Marc Kleine-Budde <mkl@pengutronix.de>, Mark Rutland <mark.rutland@arm.com>, linux-can@vger.kernel.org, netdev <netdev@vger.kernel.org>, "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, "Franklin S Cooper Jr." <fcooper@ti.com>, Wenyou Yang <Wenyou.Yang@microchip.com>, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>, linux-omap <linux-omap@vger.kernel.org>, Dong Aisheng <b29396@freescale.com>
List-Id: linux-omap@vger.kernel.org

Hi Rob,

On Friday 12 January 2018 01:50 AM, Rob Herring wrote:
> On Wed, Jan 10, 2018 at 4:55 AM, Faiz Abbas <faiz_abbas@ti.com> wrote:
>> From: Franklin S Cooper Jr <fcooper@ti.com>
>>
>> Add information regarding can-transceiver binding. This is especially
>> important for MCAN since the IP allows CAN FD mode to run significantly
>> faster than what most transceivers are capable of.
>>
>> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
>> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
>> Signed-off-by: Faiz Abbas <faiz_abbas@ti.com>
>> ---
>>  Documentation/devicetree/bindings/net/can/m_can.txt | 9 +++++++++
>>  1 file changed, 9 insertions(+)
> 
> Why did you drop my ack from v6?

Sorry, I missed it. Will make sure its there in future versions.

Thanks,
Faiz
