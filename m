From: Rob Lee <rob.lee@linaro.org>
Subject: Re: [PATCH v6 1/9] cpuidle: Add common time keeping and irq enabling
Date: Wed, 29 Feb 2012 07:30:25 -0600
Message-ID: <CAMXH7KECx5KHX55FE+v0bOUvq1xvc69D+F7nAEROxA2xf92CvQ@mail.gmail.com>
References: <1330485109-7327-1-git-send-email-rob.lee@linaro.org>
	<1330485109-7327-2-git-send-email-rob.lee@linaro.org>
	<CAORVsuX3nJAgbDY+oNQ+OD6xeZt=OkhK4n769Y+xJb0NXcrBmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <CAORVsuX3nJAgbDY+oNQ+OD6xeZt=OkhK4n769Y+xJb0NXcrBmw@mail.gmail.com>
Sender: linux-sh-owner@vger.kernel.org
To: Jean Pihet <jean.pihet@newoldbits.com>
Cc: len.brown@intel.com, khilman@ti.com, robherring2@gmail.com, Baohua.Song@csr.com, amit.kucheria@linaro.org, nicolas.ferre@atmel.com, linux@maxim.org.za, kgene.kim@samsung.com, amit.kachhap@linaro.org, magnus.damm@gmail.com, nsekhar@ti.com, daniel.lezcano@linaro.org, mturquette@linaro.org, vincent.guittot@linaro.org, arnd.bergmann@linaro.org, linux-arm-kernel@lists.infradead.org, linaro-dev@lists.linaro.org, patches@linaro.org, deepthi@linux.vnet.ibm.com, broonie@opensource.wolfsonmicro.com, nicolas.pitre@linaro.org, linux@arm.linux.org.uk, venki@google.com, ccross@google.com, g.trinabh@gmail.com, kernel@wantstofly.org, lethal@linux-sh.org, jon-hunter@ti.com, tony@atomide.com, linux-omap@vger.kernel.org, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On Wed, Feb 29, 2012 at 2:30 AM, Jean Pihet <jean.pihet@newoldbits.com>=
 wrote:
> Hi Rob,
>
> On Wed, Feb 29, 2012 at 4:11 AM, Robert Lee <rob.lee@linaro.org> wrot=
e:
>> Make necessary changes to implement time keeping and irq enabling
>> in the core cpuidle code. =A0This will allow the removal of these
>> functionalities from various platform cpuidle implementations whose
>> timekeeping and irq enabling follows the form in this common code.
>>
>> Signed-off-by: Robert Lee <rob.lee@linaro.org>
>> ---
>> =A0arch/arm/include/asm/cpuidle.h | =A0 14 ++++++
>> =A0drivers/cpuidle/cpuidle.c =A0 =A0 =A0| =A0 90 +++++++++++++++++++=
+++++++++++++--------
>> =A0include/linux/cpuidle.h =A0 =A0 =A0 =A0| =A0 13 ++++++
>> =A03 files changed, 99 insertions(+), 18 deletions(-)
>> =A0create mode 100644 arch/arm/include/asm/cpuidle.h
>>
> ...
>
>> diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
>> index 59f4261..00b02f5 100644
>> --- a/drivers/cpuidle/cpuidle.c
>> +++ b/drivers/cpuidle/cpuidle.c
> ...
>
>> @@ -110,7 +126,8 @@ int cpuidle_idle_call(void)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->states_usage[entered_state].time=
 +=3D
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsi=
gned long long)dev->last_residency;
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->states_usage[entered_state].usag=
e++;
>> - =A0 =A0 =A0 }
>> + =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev->last_residency =3D 0;
> Braces are required here, according to the coding style doc.

Thanks.

>
> ...
>
> Regards,
> Jean
