From: Claudio Foellmi <claudio.foellmi@ergon.ch>
Subject: Re: [PATCH v2] i2c: omap: Trigger bus recovery in lockup case
Date: Mon, 30 Oct 2017 10:11:57 +0100
Message-ID: <47a1c363-d9a4-015f-60c7-35dca8a41f26@ergon.ch>
References: <e9b43138-6c01-bc99-9bac-355823bc0c19@ti.com>
 <1507110225-3050-1-git-send-email-claudio.foellmi@ergon.ch>
 <20171028205255.56qryat6eanhwfcz@ninjato>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20171028205255.56qryat6eanhwfcz@ninjato>
Content-Language: en-US
Sender: linux-i2c-owner@vger.kernel.org
To: Wolfram Sang <wsa@the-dreams.de>
Cc: Tony Lindgren <tony@atomide.com>, "Nori, Sekhar" <nsekhar@ti.com>, "Cooper Jr., Franklin" <fcooper@ti.com>, Aaro Koskinen <aaro.koskinen@iki.fi>, Sebastian Reichel <sebastian.reichel@collabora.co.uk>, linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, Grygorii Strashko <grygorii.strashko@ti.com>, Vignesh R <vigneshr@ti.com>
List-Id: linux-omap@vger.kernel.org

On 10/28/2017 10:52 PM, Wolfram Sang wrote:
> 
>> +	if (!(systest & OMAP_I2C_SYSTEST_SCL_I_FUNC))
>> +		return -ETIMEDOUT; /* recovery would not fix SCL */
> 
> I'd rather return EBUSY here. It is not that the transaction timed out.
> If you agree, I can fix it locally, no need to resend.
> 
> Rest looks good, thanks!
>

Agreed, EBUSY is the better choice since that is also what the actual recovery would return.

Thanks,
Claudio
