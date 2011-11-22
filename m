From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 4/6] OMAP3: cpuidle: next C-state decision
 depends on the PM QoS MPU and CORE constraints
Date: Tue, 22 Nov 2011 20:54:14 +0100
Message-ID: <CAORVsuV5bV-p0kxhh8g4T076Dg3Mj89X_=4E+BpCSTdLiUmNZA@mail.gmail.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-5-git-send-email-j-pihet@ti.com>
	<877h2y30a5.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <877h2y30a5.fsf@ti.com>
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
Cc: linux-omap@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

On Thu, Nov 17, 2011 at 10:29 PM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> The MPU latency figures for cpuidle include the MPU itself and also
>> the peripherals needed for the MPU to execute instructions (e.g.
>> main memory, caches, IRQ controller, MMU etc). On OMAP3 those
>> peripherals belong to the MPU and CORE power domains and so the
>> cpuidle C-states are a combination of MPU and CORE states.
>>
>> This patch implements the relation between the cpuidle and per-
>> device PM QoS frameworks in the OMAP3 specific idle callbacks.
>>
>> The chosen C-state shall satisfy the following conditions:
>> =A0. the 'valid' field is enabled,
>> =A0. it satisfies the enable_off_mode flag,
>
> Not directly related to this patch, but is there any reason to keep the
> 'enable_off_mode' flag after this series?
enable_off_mode could be removed completely after this series unless
there is a need to prevent OFF mode for debug reasons.

>
> Kevin
>

Thanks,
Jean
