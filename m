From: Dirk Behme <dirk.behme@googlemail.com>
Subject: Re: [PATCH] ARM: OMAP2: Update N800 defconfig
Date: Sun, 04 Mar 2007 17:36:09 +0100
Message-ID: <45EAF579.50404@googlemail.com>
References: <45EA9F87.6090300@googlemail.com>	<85649hjnnp.fsf@orfeo.duckcorp.org>
	<45EAB2E7.1000607@googlemail.com>
	<85y7mdgpww.fsf@orfeo.duckcorp.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-omap-open-source-bounces@linux.omap.com>
In-Reply-To: <85y7mdgpww.fsf@orfeo.duckcorp.org>
List-Unsubscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=unsubscribe>
List-Archive: <http://linux.omap.com/pipermail/linux-omap-open-source>
List-Post: <mailto:linux-omap-open-source@linux.omap.com>
List-Help: <mailto:linux-omap-open-source-request@linux.omap.com?subject=help>
List-Subscribe: <http://linux.omap.com/mailman/listinfo/linux-omap-open-source>,
	<mailto:linux-omap-open-source-request@linux.omap.com?subject=subscribe>
Sender: linux-omap-open-source-bounces@linux.omap.com
Errors-To: linux-omap-open-source-bounces@linux.omap.com
To: "Arnaud Patard (Rtp)" <arnaud.patard@rtp-net.org>, linux-omap-open-source@linux.omap.com
List-Id: linux-omap@vger.kernel.org

Arnaud Patard (Rtp) wrote:
> Dirk Behme <dirk.behme@googlemail.com> writes:
> 
> 
>>Arnaud Patard (Rtp) wrote:
>>
>>>>Update N800 defconfig, mainly to disable netfilter which
>>>>doesn't compile:
>>>
>>> Fixing the build may be a better idea than disabling it.
>>
>>Yes, your are right ;) But this is something we can't do here on OMAP
>>list.
> 
> 
> I disagree. This driver afaik can only be found in the omap tree and
> it's only a matter of taking few minutes to update the driver to follow
> upstream changes. So, unless the original author of the driver fixes it
> (which I doubt), it's up to us to fix it.

Uups, we have some OMAP specifc stuff in net/ipv4/netfilter? 
I wasn't aware of this. Yes, then your are right that we 
have to fix it. I thought it is an upstream issue. Then, 
forget my N800 defconfig changes, thanks for the correction 
and the patch.

Dirk
