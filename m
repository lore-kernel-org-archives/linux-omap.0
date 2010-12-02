From: "Kanigeri, Hari" <h-kanigeri2@ti.com>
Subject: Re: [RFC v2 1/8] TILER-DMM: DMM-PAT driver for TI TILER
Date: Wed, 1 Dec 2010 20:27:24 -0600
Message-ID: <AANLkTik1o4Ka_UnwWvmjVhQGrPwrOpPGG4mmu4zSiH+U@mail.gmail.com>
References: <1291147139-23472-1-git-send-email-davidsin@ti.com>
	<1291147139-23472-2-git-send-email-davidsin@ti.com>
	<AANLkTi=q1HzYBpMH_pP+S5BtBQpHs62+zNfd_MtWHFuu@mail.gmail.com>
	<AANLkTi=YUYuxQE8pDZrN5-PJq1Q3jw7cP2yZKCXNAvPP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <AANLkTi=YUYuxQE8pDZrN5-PJq1Q3jw7cP2yZKCXNAvPP@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Varadarajan, Charulatha" <charu@ti.com>
Cc: David Sin <davidsin@ti.com>, Greg KH <greg@kroah.com>, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Lajos Molnar <molnar@ti.com>
List-Id: linux-omap@vger.kernel.org

On Wed, Dec 1, 2010 at 8:10 PM, Kanigeri, Hari <h-kanigeri2@ti.com> wro=
te:
> On Wed, Dec 1, 2010 at 12:04 AM, Varadarajan, Charulatha <charu@ti.co=
m> wrote:
>> David,
>
>>
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!oh)
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto error;
>>> +
>>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 data->base =3D oh->_mpu_rt_va;
>>
>> not required. Make use of platform_get APIs in probe to extract the
>> base, dma and irq info using pdev.
>
> Not sure about using platform_get APIs. I think one has to use
> omap_hwmod_get_mpu_rt_va to get the address, which internally returns
> oh-<_mpu_rt_va.
small correction... omap_device_get_rt_va and not omap_hwmod_get_mpu_rt=
_va.

Thank you,
Best regards,
Hari Kanigeri
