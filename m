From: Mark Brown <broonie@sirena.org.uk>
Subject: Re: AIC23 SOC Driver on OSK5912
Date: Tue, 7 Oct 2008 16:12:15 +0100
Message-ID: <20081007151214.GH19835@sirena.org.uk>
References: <e762f7a90810070448g6eb4545ay340e6be8de775133@mail.gmail.com>
	<20081007115450.GD19835@sirena.org.uk>
	<dfeb90390810070502x42ec3d85heb87f21d5c3074ec@mail.gmail.com>
	<e762f7a90810070506q2d4e299eqe2d6d9bc515aeec0@mail.gmail.com>
	<e762f7a90810070506x9c26ecfh6fa68a833c2ae98b@mail.gmail.com>
	<e762f7a90810070518r22dfa404s3f34f3ade79db7bf@mail.gmail.com>
	<48EB6820.3090809@mistralsolutions.com>
	<e762f7a90810070650q642aa05eu1f909e7898042ee6@mail.gmail.com>
	<dfeb90390810070809r481f1a55wba410516bf2d1e9e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Content-Disposition: inline
In-Reply-To: <dfeb90390810070809r481f1a55wba410516bf2d1e9e@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Arun KS <arunks@mistralsolutions.com>
Cc: alsa-devel@alsa-project.org, "linux-omap@vger.kernel.org List" <linux-omap@vger.kernel.org>, Jesslyn Abdul Salam <jesslyn.abdulsalam@gmail.com>
List-Id: linux-omap@vger.kernel.org

On Tue, Oct 07, 2008 at 08:39:07PM +0530, Arun KS wrote:
> On Tue, Oct 7, 2008 at 7:20 PM, Jesslyn Abdul Salam

> > Not yet. Would please share what you have done to make it work ? Also when I
> > tried to strace aplay , it keeps looking for a
> > </share/alsa/cards/tlv320aic23.conf> file which is not there in the alsa-lib
> > package. Any idea what goes in that file ?

> CCing in l-o mailing list too.

> I dont know about that file. I didnt face that issue.

It's perfectly normal to check that file, it doesn't need to be there -
it contains optional ALSA control configuration for the card in the same
format as the other files in there.  Note that usually it'd appear in
/usr/share rather than /usr, this may indicate that your ALSA user space
is not configured as one would expect.
