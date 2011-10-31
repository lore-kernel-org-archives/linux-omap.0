From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Subject: Re: [PATCH v9 2/4] cpuidle: Remove CPUIDLE_FLAG_IGNORE and dev->prepare()
Date: Mon, 31 Oct 2011 13:02:27 +0530
Message-ID: <4EAE4F0B.2050500@linux.vnet.ibm.com>
References: <20111028104945.7520.83828.stgit@localhost6.localdomain6> <20111028105020.7520.68014.stgit@localhost6.localdomain6> <4EAABB07.3000305@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <4EAABB07.3000305@linux.intel.com>
Sender: linux-acpi-owner@vger.kernel.org
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: khilman@ti.com, venki@google.com, ak@linux.intel.com, len.brown@intel.com, peterz@infradead.org, rjw@sisk.pl, santosh.shilimkar@ti.com, lenb@kernel.org, linux-pm@vger.kernel.org, linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Friday 28 October 2011 07:54 PM, Arjan van de Ven wrote:
> 
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
> 
> On 10/28/2011 3:50 AM, Deepthi Dharwar wrote:
>> The cpuidle_device->prepare() mechanism causes updates to the
>> cpuidle_state[].flags, setting and clearing CPUIDLE_FLAG_IGNORE
>> to tell the governor not to chose a state on a per-cpu basis at
>> run-time. State demotion is now handled by the driver and it returns
>> the actual state entered. Hence, this mechanism is not required.
>> Also this removes per-cpu flags from cpuidle_state enabling
>> it to be made global.
>>
> 
> having worked on some newer platforms....
> this one is really still needed. doing this inside the actual states
> does not work,
> because if the deepest 3 states are invalid, the same (somewhat
> expensive) test would have to be done 3 times,
> and each of the states would have to fail before the 4th one gets chosen.
> that's just not going to work
> 
> (in the state handler you can't know what other state to fall back to,
> and especially not how to enter such a fallback state)
> 
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.17 (MingW32)
> 
> iQEcBAEBAgAGBQJOqrsGAAoJEEHdSxh4DVnEu7EH/i5lEJctBAIubJOcZz/tvBFp
> XYmAe/HqNtSXeHOVsJkTf8y4ppE8487exF7xxMik4GRN0CZNCtkyMezqDVu+eDim
> O/UUbScsAc5cSY6mkjOFXLFup+mi1nkRUnAbxXEyTMhWwcbfr2OvcuO7l7TmATML
> hu87P3PVEafEop3q2+uWMc57fFxnNFfEDqRx6N9V+OJKV5dHrRYL4G4E01fYGFLo
> xTR0IW7nB15L0C29zk9uk/Dqow8SoJZA83c7p7AieP5zdntb6p7noIf03qmdp19f
> fulwMwembCHivo+pLO+jAMhKD1T6VYoCyiYW0LHrQ2E07fayBhFJCxlazgKFcl0=
> =FL6o
> -----END PGP SIGNATURE-----
> 
Hi Arjan,

Thanks for the review. 

We retain the dev->prepare() routine and CPUIDLE_FLAG_IGNORE 
but still allow the dev->enter() to return index ? 
So by retaining it, transition to the idle states
would be much quicker in case one more states are invalid.

Also to note is that in the newer design, we have split the 
cpuidle_state structure. One global struct, cpuidle_states[] that
contains all the state related information including flags, and 
the other cpuidle_device that contain statistics and other data 
that are per-cpu basis. 
So the flags are not per cpu per state basis but 
maintained globally as per state basis. 

So if we have to enable CPUIDLE_FLAG_IGNORE flag in this 
current new design, then I am thinking if we needed to have this 
on a per-cpu basis. If so, then flags have to be moved into cpuidle_device 
struct rather than cpuidle_state struct. 

Is it a good idea to retain these flags as global (part of cpuidle_states) 
or make it per-cpu basis ? 

-Thanks
Deepthi   

