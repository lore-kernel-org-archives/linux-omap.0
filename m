From: Keerthy <j-keerthy@ti.com>
Subject: Re: NFSroot regression in next with handle inode->i_version
Date: Wed, 10 Jan 2018 16:29:22 +0530
Message-ID: <b58b7309-a897-dd4a-d992-f77b1341298e@ti.com>
References: <20180109210121.GX3875@atomide.com>
 <1515532316.3571.20.camel@redhat.com> <20180109212147.GY3875@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180109212147.GY3875@atomide.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Tony Lindgren <tony@atomide.com>, Jeff Layton <jlayton@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>, linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-omap@vger.kernel.org



On Wednesday 10 January 2018 02:51 AM, Tony Lindgren wrote:
> * Jeff Layton <jlayton@redhat.com> [180109 21:14]:
>> On Tue, 2018-01-09 at 13:01 -0800, Tony Lindgren wrote:
>>> Commit 4b5bd6a8e7cf ("fs: handle inode->i_version more efficiently")
>>> causes NFSroot to not boot to login in Linux next on my ARM boxes.
> 
>> Krzysztof Kozlowski reported this late last week, and I just pushed an
>> updated branch earlier this morning that should fix this. It looks like
>> the current linux-next HEAD has the fixed patchset now too. Let me know
>> if that doesn't help you.
> 
> OK great, thanks for the update. I'll test again tomorrow and will
> whine again if I'm seeing issues :)

This fixes nfs boot for me on dra7-evm.

Regards,
Keerthy

> 
> Regards,
> 
> Tony
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
