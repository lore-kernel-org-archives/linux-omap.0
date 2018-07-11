From: "Marcel Partap (unterwegs)" <mpartap@gmx.net>
Subject: Re: v4.18-rc2 on droid4: screen turns red
Date: Wed, 11 Jul 2018 12:58:35 +0200
Message-ID: <8EB5195E-E329-4001-8C1C-185D25FE6AD3@gmx.net>
References: <20180630131812.GA549@amd> <20180711102655.GA6864@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180711102655.GA6864@amd>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-omap@vger.kernel.org, tony@atomide.com, sre@kernel.org, nekit1000@gmail.com, merlijn@wizzup.org
List-Id: linux-omap@vger.kernel.org

Might this be possible to reproduce with qemu-system-arm, maybe with -icount align=off (?) to speed it up ?
Guess a bisect on the device itself would be kind of a hassle..
If I get my spare droid4 to boot again I'll send it to Prague so you can compare & see if it is somewhat deterministic ; )

Regards!
#marcel


On July 11, 2018 12:26:55 PM CEST, Pavel Machek <pavel@ucw.cz> wrote:
>Hi!
>
>> After longer inactivity, attempt to wake up the screen results in
>> screen being completely red. Not too useful. I can still connect over
>> ssh.
>
>Still there in -rc4 :-(. But happens only once in a few days for me...
>
>When X is shut down, text console works ok.

-- 
Diese Nachricht wurde von meinem Android-Mobiltelefon mit K-9 Mail gesendet.
