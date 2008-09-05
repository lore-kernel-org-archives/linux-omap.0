From: "Steve Sakoman" <sakoman@gmail.com>
Subject: Re: [PATCH 3/5] SOUND: SOC: CODECS: Add support for
	the TWL4030 audio codec
Date: Fri, 5 Sep 2008 07:25:58 -0700
Message-ID: <5e088bd90809050725g38a053edy2d771b848242d4e6@mail.gmail.com>
References: <1220504520-6067-1-git-send-email-sakoman@gmail.com>
	<1220504520-6067-2-git-send-email-sakoman@gmail.com>
	<1220504520-6067-3-git-send-email-sakoman@gmail.com>
	<1220504520-6067-4-git-send-email-sakoman@gmail.com>
	<20080904132632.e64c3ce2.jarkko.nikula@nokia.com>
	<5e088bd90809040732x24b2123cl68fa9d2242ae2ae0@mail.gmail.com>
	<20080905103040.GD12383@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
In-Reply-To: <20080905103040.GD12383@sirena.org.uk>
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
To: Steve Sakoman <sakoman@gmail.com>, Jarkko Nikula <jarkko.nikula@nokia.com>, alsa-devel@alsa-project.org, linux-omap@vger.kernel.org, Steve Sakoman <steve@sakoman.com>
List-Id: linux-omap@vger.kernel.org

On Fri, Sep 5, 2008 at 3:30 AM, Mark Brown <broonie@sirena.org.uk> wrote:
> On Thu, Sep 04, 2008 at 07:32:28AM -0700, Steve Sakoman wrote:
>> On Thu, Sep 4, 2008 at 3:26 AM, Jarkko Nikula <jarkko.nikula@nokia.com> wrote:
>
>> I could probably get rid of this function.  It was quite useful during
>> debugging and I was not aware of codec_reg_show.  IIRC, most of the
>> other codec drivers also have the equivalent of this function, so we
>> might want to clean them up too if there is a standard function to
>> replace them.
>
> Any references?  None of the in-tree drivers have them...

Heh, you are correct.

I could swear I did a cut'n'paste on the reg cache stuff including the
dump.  Perhaps just old timers disease . . .

>> It *seems* to work without them, but every historic TI driver seemed
>> to have them.  I figured that they might know something not reflected
>> in the documentation.  I will add a REVIST comment.
>
> This sort of stuff is very common in codec drivers - normally the delays
> are there to allow the analogue side of the system time to settle down
> (waiting for capacitors to charge/discharge or reference voltages to
> stabalise, for example).  Ideally they have comments saying what's going
> on, of course.  Missing these delays often won't actually stop things
> working completely but will instead do things like reduce performance or
> generate audio artefacts - and sometimes it's application dependant if
> these are important.

That was my assumption too, so I left them under the "better safe than
sorry" theory.

As suggested, I moved all sets and clears of CODEXPDZ to function
calls which include the delay.

Thanks again for the comments.

Steve
