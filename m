From: Colin Cross <ccross@android.com>
Subject: Re: [PATCH 0/3] coupled cpuidle state support
Date: Tue, 13 Mar 2012 17:47:20 -0700
Message-ID: <CAMbhsRRD2bdkcUZvScb-cF05e=R3h69bNVaTPFX4jBKBBOjuMg@mail.gmail.com>
References: <1324426147-16735-1-git-send-email-ccross@android.com>
	<4F1929E9.7070707@linaro.org> <8762e8kqi6.fsf@ti.com>
	<CAMbhsRRZ+xt179RN32-+eBWngbRow=MpKV1XcLvG-sHGF6VOJA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <CAMbhsRRZ+xt179RN32-+eBWngbRow=MpKV1XcLvG-sHGF6VOJA@mail.gmail.com>
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
Cc: Len Brown <len.brown@intel.com>, linux-kernel@vger.kernel.org, Amit Kucheria <amit.kucheria@linaro.org>, linux-tegra@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Tue, Mar 13, 2012 at 5:28 PM, Colin Cross <ccross@android.com> wrote:
> On Tue, Mar 13, 2012 at 4:52 PM, Kevin Hilman <khilman@ti.com> wrote:
>> Hi Colin,
>>
>> On 12/21/2011 01:09 AM, Colin Cross wrote:
>>
>>> To use coupled cpuidle states, a cpuidle driver must:
>>
>> [...]
>>
>>> =A0 =A0 Provide a struct cpuidle_state.enter function for each state
>>> =A0 =A0 that affects multiple cpus. =A0This function is guaranteed to be
>>> =A0 =A0 called on all cpus at approximately the same time. =A0The driver
>>> =A0 =A0 should ensure that the cpus all abort together if any cpu tries
>>> =A0 =A0 to abort once the function is called.
>>
>> I've discoved the last sentence above is crucial, and in order to catch
>> all the corner cases I found it useful to have the struct
>> cpuidle_coupled in cpuidle.h so that the driver can check ready_count
>> itself (patch below, on top of $SUBJECT series.)
>
> ready_count is an internal state of core coupled code, and will change
> significantly in the next version of the patches. =A0Drivers cannot
> depend on it.
>
>> As you know, on OMAP4, when entering the coupled state, CPU0 has to wait
>> for CPU1 to enter its low power state before entering itself. =A0The fir=
st
>> pass at implementing this was to just spin waiting for the powerdomain
>> of CPU1 to hit off. =A0That works... most of the time.
>>
>> If CPU1 wakes up immediately (or before CPU0 starts checking), or more
>> likely, fails to hit the low-power state because of other hardware
>> "conditions", CPU0 will end up stuck in the loop waiting for CPU1.
>>
>> To solve this, in addition to checking the power state of CPU1, I also
>> check if (coupled->ready_count !=3D cpumask_weight(&coupled->alive_coupl=
ed_cpus)).
>> If true, it means that CPU1 has already exited/aborted so CPU0 had
>> better abort as well.
>>
>> Checking the ready_count seemed like an easy way to do this, but did you
>> have any other mechanisms in mind for CPUs to communicate that they've
>> exited/aborted?
>
> Why not set a flag from CPU1 when it exits the low power state, and
> have CPU0 spin on the powerdomain register or the flag? =A0You can then
> use the parallel barrier function to ensure both cpus have seen the
> flag and reset it to 0 before returning.

I realized the parallel barrier helper was not included in the patch
set I posted, it will be in the next patch set.  Short version, no
caller to cpuidle_coupled_parallel_barrier will return before all cpus
in the coupled set have called it.  It allows you to resynchronize the
cpus after an abort to ensure they have all seen the abort flag before
clearing it and returning, leaving everything in the correct state for
the next idle attempt.
