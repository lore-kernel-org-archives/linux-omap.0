From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [linux-pm] [PATCH 0/8] Suspend block api (version 8)
Date: Wed, 26 May 2010 17:45:00 +0200
Message-ID: <1274888700.1674.1760.camel@laptop>
References: <1274482015-30899-1-git-send-email-arve@android.com>
	 <201005242049.18920.rjw@sisk.pl> <87wrusvrqe.fsf@deeprootsystems.com>
	 <201005250138.16293.rjw@sisk.pl> <1274863655.5882.4875.camel@twins>
	 <AANLkTinN6MKvCEhPkbYQRD2gu-mGXdNW9asRsTuKN3_Y@mail.gmail.com>
	 <1274867106.5882.5090.camel@twins>
	 <20100526120242.5c9b73ad@schatten.dmk.lab>
	 <AANLkTim4021cTnhVZrQpefq1MG-eEPOFLDRO-XDepHb4@mail.gmail.com>
	 <20100526133721.602633b2@schatten.dmk.lab>
	 <AANLkTikzgaOFdQKess4E-D86OLPOzxP3dWiDkU_UR0ri@mail.gmail.com>
	 <20100526142430.327ccbc4@schatten.dmk.lab>
	 <20100526141612.3e2e0443@lxorguk.ukuu.org.uk>
	 <20100526171106.0e44a736@schatten.dmk.lab>
	 <1274886947.1674.1757.camel@laptop>
	 <20100526174049.5f803b4a@schatten.dmk.lab>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20100526174049.5f803b4a@schatten.dmk.lab>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Mickler <florian@mickler.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Vitaly Wool <vitalywool@gmail.com>, LKML <linux-kernel@vger.kernel.org>, Paul@smtp1.linux-foundation.org, felipe.balbi@nokia.com, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>
List-Id: linux-omap@vger.kernel.org

On Wed, 2010-05-26 at 17:40 +0200, Florian Mickler wrote:
> On Wed, 26 May 2010 17:15:47 +0200
> Peter Zijlstra <peterz@infradead.org> wrote:
> 
> > On Wed, 2010-05-26 at 17:11 +0200, Florian Mickler wrote:
> > > I'm not saying that your argument is not valid. But why don't you look
> > > at suspend blockers as a contract between userspace and kernelspace? An
> > > Opt-In to the current guarantees the kernel provides in the non-suspend
> > > case.
> > 
> > That's backwards.
> 
> I think that's the point of it. 

Apparently, and you're not accepting that we're telling you we think its
a singularly bad idea. Alan seems to have the skill to clearly explain
why, I suggest you re-read his emails again.
