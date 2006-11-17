From: Arnaud Patard (Rtp) <arnaud.patard@rtp-net.org>
Subject: Re: DSP support on current git
Date: Fri, 17 Nov 2006 13:51:26 +0100
Message-ID: <85fyci9qy9.fsf@orfeo.duckcorp.org>
References: <85bqnbw1n4.fsf@orfeo.duckcorp.org> <45590004.4050004@cc.jyu.fi>
	<85slgmtpv1.fsf@orfeo.duckcorp.org>
	<ae36f8040611160857y7e5b563p38388127db49efb0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <ae36f8040611160857y7e5b563p38388127db49efb0@mail.gmail.com>
	(=?utf-8?Q?Lu=C3=ADs?= Cargnini's message of "Thu, 16 Nov 2006 14:57:55
	-0200")
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: lvcargnini@gmail.com
Cc: linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

"Lu=C3=ADs Cargnini" <lvcargnini@gmail.com> writes:

[ Please, don't top-post and keep the mailing-list on CC: ]


> please try the kernel org git tree for omap i sue the dspgateway and it

As I said previously, I'm unsind an uptodate using linux-omap-2.6 git
tree. Using the one from kernel.org or mvista does not matter. AFAIK the
one from kernel.org is a mirror of the one on mvista.

> works fine for me I'm using an 5912 .

ok. That tends to confirm that it's linked with my n770 kernel.

Do you have CONFIG_OMAP_DSP_FBEXPORT enabled ? If not, can you try with
it ?

This options seems to be a part of my problem. On 2.6.16 kernels, the
vram was set to 1MB which corresponds to 1 entry in the DSP TLB and now,
it's a computed value. On the n770, this change leads to the use of 23
entries. As there are only 32 entries in the table, it's not surprising
at all that I'm running out of TLB entries :((


>
> On 11/14/06, Rtp Arnaud Patard <arnaud.patard@rtp-net.org> wrote:
>>
>> lamikr <lamikr@cc.jyu.fi> writes:
>>
>> Hi !
>>
>> > Arnaud Patard (Rtp) wrote:
>> >> Hi,
>> >>
>> >> In my quest in getting the current -omap kernel working on my n770,=
 I
>> >> found that the DSP was not working. (fwiw, it's working fine with t=
he
>> >> kernel from nokia).
>> >>
>> > Did you build that kernel yourself by using kernel sources from Maem=
o
>> repo?
>>
>> As I said, I'm talking about the -omap git tree, the one from
>> mvista/kernel.org.
>>
>> Unless I missed it, there's no up-to-date kernel sources on maemo. If
>> have an url, please share it :)
>>
>> Arnaud
>>
