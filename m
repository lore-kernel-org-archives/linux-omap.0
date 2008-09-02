From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 1/4] ARM: OMAP2: Add support for the
	Gumstix Overo board
Date: Tue, 2 Sep 2008 14:06:21 -0700
Message-ID: <5e088bd90809021406n435a07d1m595ef8ca0e455989@mail.gmail.com>
References: <1220306279-27977-1-git-send-email-sakoman@gmail.com>
	<1220306279-27977-2-git-send-email-sakoman@gmail.com>
	<20080902205822.GA32575@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080902205822.GA32575@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Sep 2, 2008 at 1:58 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Sep 01, 2008 at 02:57:56PM -0700, sakoman@gmail.com wrote:
>> +             .size           =  15 * NAND_BLOCK_SIZE,
>
> Unnecessary additional spacing after '='.

<<SNIP>>

>> +struct platform_driver overo_panel_driver = {
>
> Should be static.
>

Lots of great suggestions!  I will incorporate them in my resubmission.

Thanks,

Steve
