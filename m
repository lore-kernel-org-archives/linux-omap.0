From: "Gulati, Shweta" <shweta.gulati@ti.com>
Subject: Re: [PATCH] OMAP: Added recalculation of clock rate in 'clk_set_rate'
Date: Wed, 11 May 2011 09:49:53 +0530
Message-ID: <BANLkTi=PE0kVMjHFVSFDPzxE-BL7-c==YQ@mail.gmail.com>
References: <1303291509-2305-1-git-send-email-shweta.gulati@ti.com>
	<alpine.DEB.2.00.1104201351180.12683@utopia.booyaka.com>
	<BANLkTi=Ab0EJ3fAQGHBOyPd+eAJHWcjtuA@mail.gmail.com>
	<alpine.DEB.2.00.1105061549150.30136@utopia.booyaka.com>
	<BANLkTikjm7th9mv9MOBdMT7j6QPo5Ke7Xw@mail.gmail.com>
	<20110510134216.GG25479@avinash-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20110510134216.GG25479@avinash-laptop>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
	<mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Gulati, Shweta" <shweta.gulati@ti.com>, Paul Walmsley <paul@pwsan.com>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Rajendra Nayak <rnayak@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi,

On Tue, May 10, 2011 at 7:12 PM, Avinash.H.M. <avinashhm@ti.com> wrote:
> On Tue, May 10, 2011 at 04:25:19PM +0530, Gulati, Shweta wrote:
>> Hi,
>>
>> On Sat, May 7, 2011 at 3:19 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> > On Thu, 21 Apr 2011, Gulati, Shweta wrote:
>> >
>> >> Yes, but in current code clk_set_rate of dpll3_m2 -
>> >> 'omap3_core_dpll_m2_set_rate'
>> >> doesn't update clk.rate, I will submit patch fixing that bug and will
>> >> make sure that
>> >> set_rate of all clocks should update clk.rate
>> >
>> > Ping. =A0Do you plan to post this soon? =A0This should be a trivial pa=
tch.
>> Sorry for the delay, I will post today.
>
> Hi Shweta ,
>
> To avoid delay, yesterday posted a patch for the same with your signed
> off by :
>
> http://www.spinics.net/lists/linux-omap/msg50776.html
>
> Please verify the patch and if anything is missing, please submit a new
> patch.
Thanks Avinash for posting the Patch on time.
I have checked all clk's set_rate, other than 'omap3_dpll3_m2_set_rate'
all set_rate APIs update clk rate, so the patch is complete.
Acked.
> thanks ,
>
> - Avinash
>
>
>> > - Paul
>> >
>>
>>
>>
>> --
>> Thanks,
>> Regards,
>> Shweta
>>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel@lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- =

Thanks,
Regards,
Shweta
