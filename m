From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [RFC/PATCH 9/9] OMAP2+: cpuidle only influences the
	MPU state
Date: Mon, 27 Jun 2011 08:53:25 +0200
Message-ID: <BANLkTin0TKXLB_UtySAnf4JM1q1oPgP+iQ@mail.gmail.com>
References: <1308926286-30445-1-git-send-email-j-pihet@ti.com>
	<1308926286-30445-10-git-send-email-j-pihet@ti.com>
	<4E05E153.9030006@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4E05E153.9030006@ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Santosh Shilimkar <santosh.shilimkar@ti.com>
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-omap@vger.kernel.org

Hi Santosh,

On Sat, Jun 25, 2011 at 3:23 PM, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 6/24/2011 7:38 AM, jean.pihet@newoldbits.com wrote:
>>
>> From: Jean Pihet<j-pihet@ti.com>
>>
>> Since cpuidle is a CPU centric framework it decides the MPU
>> next power state based on the MPU exit_latency and target_residency
>> figures.
>>
>> The rest of the power domains get their next power state programmed
>> from the PM_QOS_DEV_WAKEUP_LATENCY class of the PM QoS framework,
>> via the device wake-up latency constraints.
>>
>> Note: the exit_latency and target_residency figures of the MPU
>> include the MPU itself and the peripherals needed for the MPU to
>> execute instructions (e.g. main memory, caches, IRQ controller,
>> MMU etc). Some of those peripherals can belong to other power domains
>> than the MPU subsystem and so the corresponding latencies must be
>> included in this figure.
>>
> With above comment, I was expecting that the latency numbers
> in the table will change.
Not necessarily. I just wanted to have it clearly stated in the commit
description.
In any case I will review the figures and update them if needed.
...

>> =A0static struct cpuidle_params cpuidle_params_table[] =3D {
>> - =A0 =A0 =A0 /* C1 */
>> + =A0 =A0 =A0 /* C1 . MPU WFI + Core active */
>> =A0 =A0 =A0 =A0{2 + 2, 5, 1},
>> - =A0 =A0 =A0 /* C2 */
>> + =A0 =A0 =A0 /* C2 . MPU WFI + Core inactive */
>> =A0 =A0 =A0 =A0{10 + 10, 30, 1},
>> - =A0 =A0 =A0 /* C3 */
>> + =A0 =A0 =A0 /* C3 . MPU CSWR + Core inactive */
>> =A0 =A0 =A0 =A0{50 + 50, 300, 1},
>> - =A0 =A0 =A0 /* C4 */
>> + =A0 =A0 =A0 /* C4 . MPU OFF + Core inactive */
>> =A0 =A0 =A0 =A0{1500 + 1800, 4000, 1},
>> - =A0 =A0 =A0 /* C5 */
>> + =A0 =A0 =A0 /* C5 . MPU RET + Core RET */
>> =A0 =A0 =A0 =A0{2500 + 7500, 12000, 1},
>> - =A0 =A0 =A0 /* C6 */
>> + =A0 =A0 =A0 /* C6 . MPU OFF + Core RET */
>> =A0 =A0 =A0 =A0{3000 + 8500, 15000, 1},
>> - =A0 =A0 =A0 /* C7 */
>> + =A0 =A0 =A0 /* C7 . MPU OFF + Core OFF */
>> =A0 =A0 =A0 =A0{10000 + 30000, 300000, 1},
>
> Latency numbers still seems to include CORE PD latency as
> well. Am I missing something Jean?
The figures are looking OK.

Thanks,
Jean

>
> Regards
> Santosh
>
