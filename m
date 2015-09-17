From: Jyri Sarha <jsarha@ti.com>
Subject: Re: [PATCH] ASoC: soc-core: Fix sparse warning in
	be32_to_cpup() call
Date: Thu, 17 Sep 2015 12:33:37 +0300
Message-ID: <55FA88F1.10807@ti.com>
References: <1442476977-4284-1-git-send-email-jsarha@ti.com>
 <20150917092229.GO11268@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20150917092229.GO11268@sirena.org.uk>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>
Cc: peter.ujfalusi@ti.com, liam.r.girdwood@linux.intel.com, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

On 09/17/15 12:22, Mark Brown wrote:
> On Thu, Sep 17, 2015 at 11:02:57AM +0300, Jyri Sarha wrote:
>
>>   	val /= sizeof(u32);
>>   	for (i = 0; i < val; i++)
>> -		if (be32_to_cpup(&of_slot_mask[i]))
>> +		if (be32_to_cpup((__be32 *)&of_slot_mask[i]))
>>   			*mask |= (1 << i);
>>
>
> There was no changelog and this is setting off alarm bells since the
> cast just smashes warnings - are you sure we're not missing some other
> annotations and that a cast is the best thing here?
>

You are right, I was a bit hasty. It is better to declare of_slot_mask 
to const __be32 * in the first place, instead of just const u32 * and 
then casting it to something else.

I'll send a new patch shortly.

BR,
Jyri
