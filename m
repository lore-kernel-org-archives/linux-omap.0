From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH] TWL4030 Keypad driver - incorporated review comments
Date: Wed, 16 May 2007 21:19:21 +0400
Message-ID: <464B3D19.4080703@gmail.com>
References: <9C23CDD79DA20A479D4615857B2E2C47E26872@dlee13.ent.ti.com>	<4643C033.3020209@gmail.com>	<782515bb0705111750k20d59341r7ddda0c68e520b99@mail.gmail.com>
	<20070516161319.GE20297@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <20070516161319.GE20297@atomide.com>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: tony@atomide.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

tony@atomide.com wrote:
> * nishanth menon <menon.nishanth@gmail.com> [070511 17:51]:
>> Hi Khasim,
>>
>> On 5/10/07, Nishanth Menon <menon.nishanth@gmail.com> wrote:
>>> Syed Mohammed, Khasim stated on 5/10/2007 7:19 PM:
>>>> I feel like not doing this, fundamental reason is we don't have an open 
>>> TRM for TWL4030, this code is new to community and I don't want to confuse 
>>> developers more. This though takes some kind of space is easy to 
>>> understand and comment on. I can definitely revisit once I see some kind 
>>> of usage of TWL4030 driver in community and having a public TRM to explain 
>>> the same. Also I am just targeting drivers to get into some respectable 
>>> form in GIT then we can improve them for more functionality and
>>> I can send a patch for the same if you'd like to save yourself the
>>> effort ;).... but just hoping to save git some bytes.. and hoping to see
>> Attached is a clean up patch for the same.. - this is a follow on
>> patch in mail: Thu 5/10/2007 11:49 PM
>
> Khasim, can you repost one more time with Nishants clean-up patch merged
> if you're OK with that? It's pointless to add the driver to the git tree
> and then immediately fix it.

while testing the TWL4030 keypad driver I found that it causes I2C errors,
but Nishant's  "FIFO Handling support and broken hw workaround" patch fixes
the problem. So, the problem is not in the keypad driver itself
but it's in i2c-omap driver. Tony, consider pushing the I2C fix too.


Thanks,
Dmitry
