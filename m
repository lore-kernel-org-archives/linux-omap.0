From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [PATCH v6] ARM: omap: edma: add suspend suspend/resume hooks
Date: Wed, 27 Nov 2013 19:24:39 +0530
Message-ID: <5295F99F.6010203@ti.com>
References: <1384726754-27875-1-git-send-email-zonque@gmail.com>
 <5295F53C.8040101@ti.com> <5295F806.9030900@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <5295F806.9030900@gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Daniel Mack <zonque@gmail.com>, linux-omap@vger.kernel.org, joelf@ti.com, gururaja.hebbar@ti.com, balajitk@ti.com
Cc: nm@ti.com, Kevin Hilman <khilman@linaro.org>, s.neumann@raumfeld.com, Russ.Dill@ti.com, vaibhav.bedia@gmail.com, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org

On Wednesday 27 November 2013 07:17 PM, Daniel Mack wrote:
> Hi Sekhar,
> 
> On 11/27/2013 02:35 PM, Sekhar Nori wrote:
>> On Monday 18 November 2013 03:49 AM, Daniel Mack wrote:
> 
>>> +static int edma_pm_suspend(struct device *dev)
>>> +{
>>> +	int j, r;
>>> +
>>> +	r = pm_runtime_get_sync(dev);
>>> +	if (IS_ERR_VALUE(r)) {
>>
>> So IS_ERR_VALUE() is only for functions which may return a negative
>> number outside of MAX_ERRNO as a success indication.
>> pm_runtime_get_sync() does not appear to be one of them so just use"
>>
>> if (r < 0) { .. }
> 
> That's true. Thanks for catching this, I'll fix it. However, grepping
> through the tree, there are quite a lot places where the same mistake is
> made.

Yes, this is a common fallacy. Russell cleaned up a bunch of these a
while back.

> 
>>> +		/* Map the channel to param entry if channel mapping logic
>>> +		 * exist
>>> +		 */
>>
>> Please follow the multi-line commenting style.
> 
> Can do. However, these lines in fact follow the style that is used
> throughout the entire file ;)

:) I did not compare the rest of the file, but hey the bar keep rising
all the time.

> 
>> There are some checkpatch checks that result from lines like this.
>> Please fix these as well.
>>
>> CHECK: Alignment should match open parenthesis
>> #179: FILE: arch/arm/common/edma.c:1841:
>> +			map_queue_tc(j, queue_tc_mapping[i][0],
>> +					queue_tc_mapping[i][1]);
> 
> If you say so, even though I disagree with checkpatch.pl here. The above
> is actually more readable, right? :)

In this particular case, I agree so I am okay if you keep it as is. The
rest of the two reports are valid though.

Thanks,
Sekhar
