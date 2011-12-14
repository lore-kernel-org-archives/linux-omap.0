From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH v5 0/6] PM QoS: implement the OMAP low level
 constraints management code
Date: Wed, 14 Dec 2011 15:55:29 +0100
Message-ID: <CAORVsuUYGTqsnnpN=rm+1pk8fLwNEA70HueF_cxqt34GirafUA@mail.gmail.com>
References: <1323706701-6627-1-git-send-email-j-pihet@ti.com>
	<87zkewrpu7.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87zkewrpu7.fsf@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jean Pihet <j-pihet@ti.com>, linux-arm <linux-arm-kernel@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Hi Kevin,

On Wed, Dec 14, 2011 at 12:53 AM, Kevin Hilman <khilman@ti.com> wrote:
> Hi Jean,
>
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> . Implement the devices wake-up latency constraints using the global
>> =A0 device PM QoS notification handler which applies the constraints to =
the
>> =A0 underlying layer
>> . Implement the low level code which controls the power domains next pow=
er
>> =A0 states, through the hwmod and pwrdm layers
>> . Add cpuidle and power domains wake-up latency figures for OMAP3, cf.
>> =A0 comments in the code and [1] for the details on where the numbers
>> =A0 are magically coming from
>> . Implement the relation between the cpuidle and per-device PM QoS frame=
works
>> =A0 in the OMAP3 specific idle callbacks.
>> =A0 The chosen C-state shall satisfy the following conditions:
>> =A0 =A0. the 'valid' field is enabled,
>> =A0 =A0. it satisfies the enable_off_mode flag,
>> =A0 =A0. the next state for MPU and CORE power domains is not lower than=
 the
>> =A0 =A0 =A0state programmed by the per-device PM QoS.
>
> I had a couple minor comments on this version, but after that, feel free
> to add:
>
> Reviewed-by: Kevin Hilman <khilman@ti.com>
Thanks for reviewing!
I fixed (most of) the minor remarks and re-submitted.

> after that, this series will go upstream through Paul.
>
> Kevin

Regards,
Jean
