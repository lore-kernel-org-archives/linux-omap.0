From: Vivek Gautam <gautamvivek1987@gmail.com>
Subject: Re: [PATCH v3 04/11] usb: dwc3: Add runtime power management callbacks
Date: Wed, 3 Apr 2013 10:29:32 +0530
Message-ID: <CAFp+6iEoZFr7LNfZocJHRV-uxvyysRuJ7Az_h_4EJc2GG9c3MQ@mail.gmail.com>
References: <1364824448-14732-1-git-send-email-gautam.vivek@samsung.com>
	<1364824448-14732-5-git-send-email-gautam.vivek@samsung.com>
	<20130402083204.GH30286@arwen.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20130402083204.GH30286@arwen.pp.htv.fi>
Sender: linux-kernel-owner@vger.kernel.org
To: balbi@ti.com
Cc: Vivek Gautam <gautam.vivek@samsung.com>, linux-usb@vger.kernel.org, linux-samsung-soc@vger.kernel.org, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org, stern@rowland.harvard.edu, sarah.a.sharp@linux.intel.com, rob.herring@calxeda.com, kgene.kim@samsung.com, kishon@ti.com, dianders@chromium.org, t.figa@samsung.com, p.paneri@samsung.com
List-Id: linux-omap@vger.kernel.org

Hi Balbi,


On Tue, Apr 2, 2013 at 2:02 PM, Felipe Balbi <balbi@ti.com> wrote:
> Hi,
>
> On Mon, Apr 01, 2013 at 07:24:03PM +0530, Vivek Gautam wrote:
>> +#else
>> +#define dwc3_runtime_suspend         NULL
>> +#define dwc3_runtime_resume          NULL
>
> this #else branch is unnecessary. Look at the definition for
> SET_RUNTIME_PM_OPS()

Right, will remove this.


-- 
Thanks & Regards
Vivek
