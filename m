From: Ivaylo Dimitrov <ivo.g.dimitrov.75@gmail.com>
Subject: Re: [PATCH] regulator: twl: Enable regulators over the powerbus as
 well
Date: Sat, 26 Mar 2016 08:18:51 +0200
Message-ID: <56F629CB.9070102@gmail.com>
References: <20160325111757.GC2566@sirena.org.uk>
 <20160325150259.GA9372@earth> <20160325155419.GI2566@sirena.org.uk>
 <56F562B7.10107@gmail.com> <20160325161954.GA5028@sirena.org.uk>
 <56F56C4A.7070502@gmail.com> <20160325170558.GB5028@sirena.org.uk>
 <56F573E5.6030408@gmail.com> <20160325182017.GE5028@sirena.org.uk>
 <20160325201911.GA25471@earth> <20160325222818.GF5028@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160325222818.GF5028@sirena.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
To: Mark Brown <broonie@kernel.org>, Sebastian Reichel <sre@kernel.org>
Cc: tony@atomide.com, lgirdwood@gmail.com, linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-omap@vger.kernel.org



On 26.03.2016 00:28, Mark Brown wrote:
> On Fri, Mar 25, 2016 at 09:19:12PM +0100, Sebastian Reichel wrote:
>> On Fri, Mar 25, 2016 at 06:20:17PM +0000, Mark Brown wrote:
>
>>> Then there is a constraint that the regulators must be in normal mode
>>> and this needs to be expressed in the machine constraints.
>
>> As in adding "regulator-initial-mode = <TWL4030_OPMODE_NORMAL>;" to
>> the regulator's DT node (and providing an of_map_mode method in the
>> twl-regulator driver)?
>
> Yes, that sounds like a sensible way to do it.
>

Ok, going to send the relevant patches.
