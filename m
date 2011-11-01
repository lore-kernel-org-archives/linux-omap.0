From: Jon Povey <Jon.Povey@racelogic.co.uk>
Subject: DaVinci NAND writing utility release, was: RE: [RFC] Change ECC
	algorithm from userspace
Date: Tue, 1 Nov 2011 04:18:53 +0000
Message-ID: <70E876B0EA86DD4BAF101844BC814DFE0BF244FEEE@Cloud.RL.local>
References: <CAAwP0s0TzB2iFzYkjAsN6q-YA9d0MEd7ViOd-UUvbMf_11q8gw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Class: urn:content-classes:message
In-Reply-To: <CAAwP0s0TzB2iFzYkjAsN6q-YA9d0MEd7ViOd-UUvbMf_11q8gw@mail.gmail.com>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
	<mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: linux-mtd-bounces@lists.infradead.org
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Javier Martinez Canillas <martinez.javier@gmail.com>
Cc: dlos <davinci-linux-open-source@linux.davincidsp.com>, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: linux-omap@vger.kernel.org

Adding davinci linux open source ML to CC as folk there might find this
utility useful.

Javier Martinez Canillas wrote:
> On Fri, Oct 28, 2011 at 12:33 PM, Jon Povey
> <Jon.Povey@racelogic.co.uk> wrote:
>> linux-mtd-bounces@lists.infradead.org wrote:
>> DM355 and DM365 has similar issues as the RBL expects a different
>> OOB/ECC layout to Linux.
>>
>> What I have done is write a utility that calculates ECC and writes to
>> the mtd device in RAW mode. So to rewrite the bootloader I take care
>> of the ECC and layout at application level without changing the
>> kernel.

> Is your utility publicly available? It would be great if I can use it
> as an starting point.

Management have given the thumbs-up, this is now released under GPL v2
at https://github.com/jonpovey/flashtool

Supports DM355 and DM365 RBL layouts, ECC generation, UBI image writing,
and various bad block / range handling.

Enjoy!

--
Jon Povey
jon.povey@racelogic.co.uk

Racelogic is a limited company registered in England. Registered number 2743719 .
Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .

The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network



______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/
