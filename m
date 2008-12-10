From: "Trilok Soni" <soni.trilok@gmail.com>
Subject: Re: [PATCH] Add TI TSC2005 Touchscreen driver
Date: Wed, 10 Dec 2008 12:44:21 +0530
Message-ID: <5d5443650812092314s4b51abb2me5e0f16a36d2c18c@mail.gmail.com>
References: <5d5443650812080949h5aff6010mb7341f581841f126@mail.gmail.com>
	 <20081208182648.GA9740@uranus.ravnborg.org>
	 <20081209131705.GC6667@pure.research.nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-input-owner@vger.kernel.org>
In-Reply-To: <20081209131705.GC6667@pure.research.nokia.com>
Content-Disposition: inline
Sender: linux-input-owner@vger.kernel.org
To: Lauri Leukkunen <lauri.leukkunen@nokia.com>
Cc: ext Sam Ravnborg <sam@ravnborg.org>, David Brownell <david-b@pacbell.net>, dmitry.torokhov@gmail.com, "linux-omap@vger.kernel.org Mailing List" <linux-omap@vger.kernel.org>, linux-kernel@vger.kernel.org, spi-devel-general@lists.sourceforge.net, linux-input@vger.kernel.org
List-Id: linux-omap@vger.kernel.org

Hi Lauri,

On Tue, Dec 9, 2008 at 6:47 PM, Lauri Leukkunen
<lauri.leukkunen@nokia.com> wrote:
> On 08/12/08 19:26 +0100, ext Sam Ravnborg wrote:
>> > Add Texas Instruments TSC2005 chip touchscreen driver.
>> >
>> > Signed-off-by: Trilok Soni <soni.trilok@gmail.com>
>>
>> Hi Trilok.
>> A few nitpicks below.
>>
>> In general a very clean written driver with adequate comments - nice work!
>
> Umm, isn't this code mostly written by Nokia? At least I remember modifying
> some of it, and this version looks like Konsta Karsisto might be the last
> person touching it. Originally I think it's written by Imre Deak, probably
> based on the tsc2301 code.

Yes, you are the author. Please check first few lines of this patch,
--from field has your name :)

-- 
---Trilok Soni
http://triloksoni.wordpress.com
http://www.linkedin.com/in/triloksoni
